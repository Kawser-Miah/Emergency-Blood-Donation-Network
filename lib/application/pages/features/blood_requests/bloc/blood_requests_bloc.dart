import 'package:blood_setu/application/core/auth/auth_controller.dart';
import 'package:blood_setu/di/di.dart';
import 'package:blood_setu/domain/failures/failures.dart';
import 'package:blood_setu/domain/models/blood_request.dart';
import 'package:blood_setu/domain/usecase/blood_requests_usecase.dart';
import 'package:blood_setu/domain/usecase/location_usecase.dart';
import 'package:blood_setu/domain/usecase/mark_im_coming_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'blood_requests_event.dart';
import 'blood_requests_state.dart';

@injectable
class BloodRequestsBloc extends Bloc<BloodRequestsEvent, BloodRequestsState> {
  final BloodRequestsUseCase _useCase;
  final LocationUseCase _locationUseCase;
  final MarkImComingUseCase _markImComingUseCase;

  static const int _pageSize = 20;

  BloodRequestsBloc(this._useCase, this._locationUseCase, this._markImComingUseCase)
      : super(BloodRequestsState.initial()) {
    on<BloodRequestsEvent>((event, emit) async {
      await event.when(
        started: () => _load(emit, reset: true),
        refreshed: () => _load(emit, reset: true),
        loadMoreRequested: () async {
          if (!state.hasMore || state.isLoading || state.isLoadingMore) return;
          await _load(emit, reset: false);
        },
        searchChanged: (value) async {
          final next = state.copyWith(search: value);
          emit(next.copyWith(filtered: _applyFilters(next, next.requests)));
        },
        bloodGroupSelected: (value) async {
          final next = state.copyWith(selectedBloodGroup: value);
          emit(next.copyWith(filtered: _applyFilters(next, next.requests)));
        },
        urgencySelected: (value) async {
          final next = state.copyWith(selectedUrgency: value);
          emit(next.copyWith(filtered: _applyFilters(next, next.requests)));
        },
        filtersOpened: () async => emit(state.copyWith(showFilters: true)),
        filtersClosed: () async => emit(state.copyWith(showFilters: false)),
        filtersReset: () async {
          final next = state.copyWith(
            search: '',
            selectedBloodGroup: 'All',
            selectedUrgency: 'All',
            showFilters: false,
          );
          emit(next.copyWith(filtered: next.requests));
        },
        imComing: (requestId) async {
          final auth = getIt<AuthController>();
          final uid = auth.user?.uid;
          if (uid == null) return;
          final p = auth.profile;
          final result = await _markImComingUseCase(
            requestId: requestId,
            donorUid: uid,
            donorName: p?.fullName ?? '',
            donorBloodGroup: p?.bloodGroup ?? '',
            lastDonation: p?.lastDonation,
            totalDonations: p?.totalDonations ?? 0,
          );
          result.fold(
            (_) => emit(state.copyWith(imComingFailed: !state.imComingFailed)),
            (_) => emit(state.copyWith(imComingSuccess: !state.imComingSuccess)),
          );
        },
      );
    });
  }

  Future<void> _load(
    Emitter<BloodRequestsState> emit, {
    required bool reset,
  }) async {
    final lastNeedBy =
        !reset && state.requests.isNotEmpty
            ? state.requests.last.needBy
            : null;

    if (reset) {
      emit(
        state.copyWith(
          isLoading: true,
          isLoadingMore: false,
          error: null,
          requests: const [],
          filtered: const [],
          hasMore: true,
        ),
      );
      final locationResult = await _locationUseCase.getAddressData();
      locationResult.fold(
        (_) {},
        (data) => emit(
          state.copyWith(userLat: data.latitude, userLng: data.longitude),
        ),
      );
    } else {
      emit(state.copyWith(isLoading: false, isLoadingMore: true, error: null));
    }

    final result = await _useCase(limit: _pageSize, startAfterNeedBy: lastNeedBy);

    result.fold(
      (f) => emit(
        state.copyWith(
          error: f is GeneralFailure ? f.message : 'Something went wrong.',
          isLoading: false,
          isLoadingMore: false,
        ),
      ),
      (fetched) {
        final all = reset
            ? fetched
            : [...state.requests, ...fetched];
        emit(
          state.copyWith(
            requests: all,
            filtered: _applyFilters(state, all),
            hasMore: fetched.length >= _pageSize,
            isLoading: false,
            isLoadingMore: false,
            error: null,
          ),
        );
      },
    );
  }

  static List<BloodRequest> _applyFilters(
    BloodRequestsState state,
    List<BloodRequest> requests,
  ) {
    var results = requests;

    if (state.selectedBloodGroup != 'All') {
      results = results
          .where((r) => r.bloodGroup == state.selectedBloodGroup)
          .toList();
    }

    if (state.selectedUrgency != 'All') {
      results =
          results.where((r) => r.urgency == state.selectedUrgency).toList();
    }

    final q = state.search.toLowerCase().trim();
    if (q.isNotEmpty) {
      results = results
          .where(
            (r) =>
                r.patientName.toLowerCase().contains(q) ||
                r.hospital.toLowerCase().contains(q) ||
                r.address.toLowerCase().contains(q) ||
                r.bloodGroup.toLowerCase().contains(q),
          )
          .toList();
    }

    return results;
  }
}
