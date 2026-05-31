import 'package:blood_setu/application/core/auth/auth_controller.dart';
import 'package:blood_setu/di/di.dart';
import 'package:blood_setu/domain/failures/failures.dart';
import 'package:blood_setu/domain/models/nearby_donor.dart';
import 'package:blood_setu/domain/usecase/nearby_donors_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'donors_event.dart';
import 'donors_state.dart';

@injectable
class DonorsBloc extends Bloc<DonorsEvent, DonorsState> {
  final NearbyDonorsUseCase _useCase;

  static const List<double> _radiusStepsKm = [5, 10, 25, 50, 100];

  static const Map<String, double> _distanceFilterMap = {
    '2km': 2,
    '5km': 5,
    '10km': 10,
    '20km': 20,
  };

  double? _latitude;
  double? _longitude;

  DonorsBloc(this._useCase) : super(DonorsState.initial()) {
    on<DonorsEvent>((event, emit) async {
      await event.when(
        started: () => _load(emit, radiusIndex: 0, reset: true),
        refreshed: () =>
            _load(emit, radiusIndex: 0, reset: true, refreshOrigin: true),
        loadMoreRequested: () async {
          if (state.hasReachedMax) { return; }
          if (state.status == DonorsStatus.loading ||
              state.status == DonorsStatus.loadingMore) { return; }
          await _load(emit, radiusIndex: state.radiusIndex + 1);
        },
        searchChanged: (value) async {
          final next = state.copyWith(search: value);
          emit(next.copyWith(filtered: _localFilter(next, next.donors)));
        },
        bloodGroupSelected: (value) async {
          emit(state.copyWith(selectedBloodGroup: value, showFilters: false));
          await _load(emit, radiusIndex: 0, reset: true);
        },
        distanceSelected: (value) async {
          emit(state.copyWith(selectedDistance: value));
          await _load(emit, radiusIndex: 0, reset: true);
        },
        filtersOpened: () async => emit(state.copyWith(showFilters: true)),
        filtersClosed: () async => emit(state.copyWith(showFilters: false)),
        filtersReset: () async {
          emit(state.copyWith(
            search: '',
            selectedBloodGroup: 'All',
            selectedDistance: 'All',
            showFilters: false,
          ));
          await _load(emit, radiusIndex: 0, reset: true);
        },
      );
    });
  }

  double get _maxRadius =>
      _distanceFilterMap[state.selectedDistance] ?? _radiusStepsKm.last;

  Future<void> _load(
    Emitter<DonorsState> emit, {
    required int radiusIndex,
    bool reset = false,
    bool refreshOrigin = false,
  }) async {
    final uid = getIt<AuthController>().user?.uid;
    if (uid == null) {
      emit(state.copyWith(
        status: DonorsStatus.failure,
        errorMessage: 'You need to be signed in.',
      ));
      return;
    }

    if (refreshOrigin || _latitude == null || _longitude == null) {
      final originResult = await _useCase.getOrigin(uid);
      final ok = originResult.fold((f) {
        emit(state.copyWith(
          status: DonorsStatus.failure,
          errorMessage: _msg(f),
        ));
        return false;
      }, (origin) {
        _latitude = origin.latitude;
        _longitude = origin.longitude;
        return true;
      });
      if (!ok) return;
    }

    final clampedIndex = radiusIndex.clamp(0, _radiusStepsKm.length - 1);
    final radius = _radiusStepsKm[clampedIndex].clamp(0, _maxRadius).toDouble();

    emit(state.copyWith(
      status: reset ? DonorsStatus.loading : DonorsStatus.loadingMore,
      errorMessage: null,
    ));

    final bloodGroup =
        state.selectedBloodGroup == 'All' ? null : state.selectedBloodGroup;

    final result = await _useCase(
      latitude: _latitude!,
      longitude: _longitude!,
      radiusKm: radius,
      bloodGroup: bloodGroup,
      excludeUid: uid,
    );

    result.fold(
      (f) => emit(state.copyWith(
        status: DonorsStatus.failure,
        errorMessage: _msg(f),
      )),
      (donors) {
        final atMax = clampedIndex >= _radiusStepsKm.length - 1 ||
            radius >= _maxRadius;
        final noNew = !reset && donors.length <= state.donors.length;
        final next = state.copyWith(
          status: DonorsStatus.success,
          donors: donors,
          radiusIndex: clampedIndex,
          hasReachedMax: atMax || noNew,
          errorMessage: null,
        );
        emit(next.copyWith(filtered: _localFilter(next, donors)));
      },
    );
  }

  static List<NearbyDonor> _localFilter(
    DonorsState state,
    List<NearbyDonor> donors,
  ) {
    final q = state.search.toLowerCase().trim();
    if (q.isEmpty) return donors;
    return donors
        .where((d) =>
            d.name.toLowerCase().contains(q) ||
            d.thana.toLowerCase().contains(q) ||
            d.district.toLowerCase().contains(q) ||
            d.bloodGroup.toLowerCase().contains(q))
        .toList();
  }

  String _msg(Failure f) =>
      f is GeneralFailure ? f.message : 'Something went wrong.';
}
