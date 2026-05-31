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

  static const int _pageSize = 50;
  static const double _maxRadiusKm = 1000;

  static const Map<String, double> _distanceFilterMap = {
    '10km': 10,
    '50km': 50,
    '100km': 100,
    '500km': 500,
  };

  double? _latitude;
  double? _longitude;
  // Cached from Firestore count() — 1 cheap read per session, no docs read.
  int? _totalDonorCount;

  DonorsBloc(this._useCase) : super(DonorsState.initial()) {
    on<DonorsEvent>((event, emit) async {
      await event.when(
        started: () => _load(
          emit,
          startRadius: 10,
          targetCount: _pageSize,
          reset: true,
        ),
        refreshed: () => _load(
          emit,
          startRadius: 10,
          targetCount: _pageSize,
          reset: true,
          refreshOrigin: true,
        ),
        loadMoreRequested: () async {
          if (state.hasReachedMax) { return; }
          if (state.status == DonorsStatus.loading ||
              state.status == DonorsStatus.loadingMore) { return; }
          await _load(
            emit,
            startRadius: _nextRadius(state.currentRadiusKm),
            targetCount: state.donors.length + _pageSize,
          );
        },
        // All filters are local — instant, no Firestore call.
        searchChanged: (value) async {
          final next = state.copyWith(search: value);
          emit(next.copyWith(filtered: _localFilter(next, next.donors)));
        },
        bloodGroupSelected: (value) async {
          final next = state.copyWith(selectedBloodGroup: value);
          emit(next.copyWith(filtered: _localFilter(next, next.donors)));
        },
        distanceSelected: (value) async {
          final next = state.copyWith(selectedDistance: value);
          emit(next.copyWith(filtered: _localFilter(next, next.donors)));
        },
        filtersOpened: () async => emit(state.copyWith(showFilters: true)),
        filtersClosed: () async => emit(state.copyWith(showFilters: false)),
        filtersApplied: () async {
          final next = state.copyWith(showFilters: false);
          emit(next.copyWith(filtered: _localFilter(next, next.donors)));
        },
        filtersReset: () async {
          final next = state.copyWith(
            search: '',
            selectedBloodGroup: 'All',
            selectedDistance: 'All',
            showFilters: false,
          );
          emit(next.copyWith(filtered: next.donors));
          await _load(
              emit, startRadius: 10, targetCount: _pageSize, reset: true);
        },
      );
    });
  }

  /// Radius progression: 10→20→40→80 (doubling), then +20 each step.
  static double _nextRadius(double current) {
    if (current < 80) return current * 2;
    return current + 20;
  }

  /// Expands radius automatically until [targetCount] donors found,
  /// all donors loaded (via collection count), or 1000km reached.
  Future<void> _load(
    Emitter<DonorsState> emit, {
    required double startRadius,
    required int targetCount,
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
            status: DonorsStatus.failure, errorMessage: _msg(f)));
        return false;
      }, (origin) {
        _latitude = origin.latitude;
        _longitude = origin.longitude;
        return true;
      });
      if (!ok) { return; }
    }

    // Fetch total count once per bloc lifetime (count() reads 0 documents).
    if (_totalDonorCount == null) {
      final countResult = await _useCase.getTotalDonorCount();
      countResult.fold((_) {}, (n) => _totalDonorCount = n);
    }

    emit(state.copyWith(
      status: reset ? DonorsStatus.loading : DonorsStatus.loadingMore,
      errorMessage: null,
    ));

    // Total donors in collection minus the current user = true max.
    final maxDonors = _totalDonorCount != null ? _totalDonorCount! - 1 : null;

    double radius = startRadius;
    List<NearbyDonor> donors = [];
    bool reachedMax = false;
    bool hadError = false;

    while (true) {
      final result = await _useCase(
        latitude: _latitude!,
        longitude: _longitude!,
        radiusKm: radius,
        excludeUid: uid,
      );

      bool shouldBreak = false;
      result.fold(
        (f) {
          emit(state.copyWith(
              status: DonorsStatus.failure, errorMessage: _msg(f)));
          hadError = true;
          shouldBreak = true;
        },
        (fetched) {
          donors = fetched;
          // All donors in the platform are loaded.
          final allLoaded = maxDonors != null && fetched.length >= maxDonors;
          if (allLoaded) {
            reachedMax = true;
            shouldBreak = true;
          } else if (fetched.length >= targetCount) {
            // Enough for this page — more may exist.
            shouldBreak = true;
          } else if (radius >= _maxRadiusKm) {
            // Hard 1000km limit reached.
            reachedMax = true;
            shouldBreak = true;
          } else {
            radius = _nextRadius(radius);
          }
        },
      );

      if (hadError || shouldBreak) break;
    }

    if (hadError) { return; }

    final next = state.copyWith(
      status: DonorsStatus.success,
      donors: donors,
      currentRadiusKm: radius,
      hasReachedMax: reachedMax,
      errorMessage: null,
    );
    emit(next.copyWith(filtered: _localFilter(next, donors)));
  }

  static List<NearbyDonor> _localFilter(
    DonorsState state,
    List<NearbyDonor> donors,
  ) {
    var results = donors;

    final maxDist = _distanceFilterMap[state.selectedDistance];
    if (maxDist != null) {
      results = results.where((d) => d.distanceKm <= maxDist).toList();
    }

    if (state.selectedBloodGroup != 'All') {
      results =
          results.where((d) => d.bloodGroup == state.selectedBloodGroup).toList();
    }

    final q = state.search.toLowerCase().trim();
    if (q.isNotEmpty) {
      results = results
          .where((d) =>
              d.name.toLowerCase().contains(q) ||
              d.thana.toLowerCase().contains(q) ||
              d.district.toLowerCase().contains(q) ||
              d.bloodGroup.toLowerCase().contains(q))
          .toList();
    }

    return results;
  }

  String _msg(Failure f) =>
      f is GeneralFailure ? f.message : 'Something went wrong.';
}
