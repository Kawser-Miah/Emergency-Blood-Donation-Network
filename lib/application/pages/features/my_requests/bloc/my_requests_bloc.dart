import 'package:blood_setu/application/core/auth/auth_controller.dart';
import 'package:blood_setu/di/di.dart';
import 'package:blood_setu/domain/usecase/get_interested_donors_usecase.dart';
import 'package:blood_setu/domain/usecase/my_requests_usecase.dart';
import 'package:blood_setu/domain/usecase/update_request_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'my_requests_event.dart';
import 'my_requests_state.dart';

@injectable
class MyRequestsBloc extends Bloc<MyRequestsEvent, MyRequestsState> {
  final MyRequestsUseCase _myRequestsUseCase;
  final UpdateRequestUseCase _updateRequestUseCase;
  final GetInterestedDonorsUseCase _getInterestedDonorsUseCase;

  MyRequestsBloc(
    this._myRequestsUseCase,
    this._updateRequestUseCase,
    this._getInterestedDonorsUseCase,
  ) : super(MyRequestsState.initial()) {
    on<MyRequestsEvent>((event, emit) async {
      await event.when(
        started: () => _load(emit),
        refreshed: () => _load(emit),
        interestedDonorsRequested: (requestId) async {
          emit(state.copyWith(
            activeRequestId: requestId,
            isLoadingDonors: true,
            interestedDonors: const [],
          ));
          final result = await _getInterestedDonorsUseCase(requestId);
          result.fold(
            (_) => emit(state.copyWith(isLoadingDonors: false)),
            (donors) => emit(
              state.copyWith(interestedDonors: donors, isLoadingDonors: false),
            ),
          );
        },
        requestUpdated: (
          id,
          patientName,
          bloodGroup,
          contact,
          hospital,
          address,
          urgency,
          units,
          needBy,
          notes,
          latitude,
          longitude,
        ) async {
          emit(state.copyWith(
            isUpdating: true,
            updateError: null,
            updateSuccess: false,
          ));
          final result = await _updateRequestUseCase(
            id: id,
            patientName: patientName,
            bloodGroup: bloodGroup,
            contact: contact,
            hospital: hospital,
            address: address,
            urgency: urgency,
            units: units,
            needBy: needBy,
            notes: notes,
            latitude: latitude,
            longitude: longitude,
          );
          await result.fold(
            (f) async => emit(state.copyWith(
              isUpdating: false,
              updateError: 'Failed to update. Please try again.',
            )),
            (_) async {
              emit(state.copyWith(isUpdating: false, updateSuccess: true));
              await _load(emit);
            },
          );
        },
        requestFulfilled: (id) async {
          emit(state.copyWith(isUpdating: true, updateError: null));
          final result = await _updateRequestUseCase.markFulfilled(id);
          await result.fold(
            (f) async => emit(state.copyWith(
              isUpdating: false,
              updateError: 'Failed to update status.',
            )),
            (_) async {
              emit(state.copyWith(isUpdating: false));
              await _load(emit);
            },
          );
        },
        requestDeleted: (id) async {
          emit(state.copyWith(isUpdating: true));
          final result = await _updateRequestUseCase.deleteRequest(id);
          result.fold(
            (_) => emit(state.copyWith(
              isUpdating: false,
              deleteFailed: !state.deleteFailed,
            )),
            (_) {
              final updated = state.requests.where((r) => r.id != id).toList();
              emit(state.copyWith(
                isUpdating: false,
                requests: updated,
                deleteSuccess: !state.deleteSuccess,
              ));
            },
          );
        },
      );
    });
  }

  Future<void> _load(Emitter<MyRequestsState> emit) async {
    final uid = getIt<AuthController>().user?.uid;
    if (uid == null) return;

    emit(state.copyWith(isLoading: true, error: null));
    final result = await _myRequestsUseCase(uid);
    result.fold(
      (f) => emit(state.copyWith(
        isLoading: false,
        error: 'Failed to load your requests.',
      )),
      (requests) => emit(
        state.copyWith(requests: requests, isLoading: false),
      ),
    );
  }
}
