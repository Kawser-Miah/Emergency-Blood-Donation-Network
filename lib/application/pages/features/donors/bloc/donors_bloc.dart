import 'package:blood_setu/application/core/auth/auth_controller.dart';
import 'package:blood_setu/application/core/services/sp_service/sp_service.dart';
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
  final SpService _spService;

  static const int _pageSize = 50;
  static const double _maxRadiusKm = 1000;
  static const String _radiusCachePrefix = 'donor_radius_';

  static const Map<String, double> _distanceFilterMap = {
    '10km': 10,
    '50km': 50,
    '100km': 100,
    '500km': 500,
  };

  double? _latitude;
  double? _longitude;
  int? _totalDonorCount;
  String _lastSearchBloodGroup = '';

  DonorsBloc(this._useCase, this._spService) : super(DonorsState.initial()) {
    on<DonorsEvent>((event, emit) async {
      await event.when(
        started: () async {
          final start = await _cachedStartRadius(state.selectedBloodGroup);
          await _load(
            emit,
            startRadius: start,
            targetCount: _pageSize,
            reset: true,
          );
        },
        refreshed: () async {
          _latitude = null;
          _longitude = null;
          await _load(
            emit,
            startRadius: 10,
            targetCount: _pageSize,
            reset: true,
            refreshOrigin: true,
          );
        },
        loadMoreRequested: () async {
          if (!state.hasMore) return;
          if (state.isLoading || state.isLoadingMore) return;
          await _load(
            emit,
            startRadius: _nextRadius(state.currentRadiusKm),
            targetCount: state.donors.length + _pageSize,
            reset: false,
          );
        },
        searchChanged: (value) async {
          final next = state.copyWith(search: value);
          emit(next.copyWith(filtered: _applyFilters(next, next.donors)));
        },
        bloodGroupSelected: (value) async {
          final hasMoreAfterSwitch = _totalDonorCount != null
              ? state.donors.length < _totalDonorCount! - 1
              : state.hasMore;
          final next = state.copyWith(
            selectedBloodGroup: value,
            hasMore: hasMoreAfterSwitch,
          );
          emit(next.copyWith(filtered: _applyFilters(next, next.donors)));
        },
        distanceSelected: (value) async {
          final next = state.copyWith(selectedDistance: value);
          emit(next.copyWith(filtered: _applyFilters(next, next.donors)));
        },
        filtersOpened: () async => emit(state.copyWith(showFilters: true)),
        filtersClosed: () async => emit(state.copyWith(showFilters: false)),
        filtersApplied: () async {
          final bloodGroupChanged =
              state.selectedBloodGroup != _lastSearchBloodGroup;
          final next = state.copyWith(showFilters: false);
          emit(next.copyWith(filtered: _applyFilters(next, next.donors)));
          if (bloodGroupChanged) {
            final start = await _cachedStartRadius(state.selectedBloodGroup);
            await _load(
              emit,
              startRadius: start,
              targetCount: _pageSize,
              reset: true,
            );
          }
        },
        filtersReset: () async {
          final next = state.copyWith(
            search: '',
            selectedBloodGroup: 'All',
            selectedDistance: 'All',
            showFilters: false,
          );
          emit(next.copyWith(filtered: next.donors));
          final start = await _cachedStartRadius('All');
          await _load(
            emit,
            startRadius: start,
            targetCount: _pageSize,
            reset: true,
          );
        },
      );
    });
  }

  // ── Radius progression ────────────────────────────────────────────────────
  //
  // 0  →  10 km  (first jump — captures everything within 10 km immediately)
  // 10 → 20 → 40 → 80  (doubling while current < 80)
  // 80 → 130 → 180 → … → 1000  (+50 km per step, hard cap at 1000 km)
  //
  // Worst-case iterations: 4 (doubling) + 19 (linear) = 23 round trips.

  static double _nextRadius(double current) {
    if (current < 10) return 10;
    if (current < 80) return current * 2;
    final next = current + 50;
    return next > _maxRadiusKm ? _maxRadiusKm : next;
  }

  // ── SharedPreferences radius cache ────────────────────────────────────────
  //
  // Stores the last radius that yielded enough donors, keyed by blood group
  // so rare types (AB-) remember they need a wider search area.
  // On next open: start at 80 % of saved radius to skip warm-up iterations
  // while giving a buffer in case the user moved to a less dense area.

  static String _cacheKey(String bg) =>
      '$_radiusCachePrefix${bg.replaceAll('+', 'p').replaceAll('-', 'm')}';

  Future<double> _cachedStartRadius(String bloodGroup) async {
    final saved = await _spService.readRandom<double>(_cacheKey(bloodGroup));
    if (saved == null) return 10;
    return (saved * 0.8).clamp(10.0, _maxRadiusKm);
  }

  Future<void> _cacheRadius(double radius, String bloodGroup) async {
    await _spService.writeRandom<double>(radius, _cacheKey(bloodGroup));
  }

  // ── Core load logic ───────────────────────────────────────────────────────
  //
  // Key behaviours:
  //   • Accumulate donors across iterations — byUid map never discards results.
  //   • Emit state after EVERY Firestore round trip so the UI updates live.
  //   • Load-more seeds byUid with existing state.donors before expanding.
  //   • Deduplication is free: byUid[uid] overwrites, keeping freshest distance.
  //   • Stop when accumulated count ≥ targetCount, all donors loaded, or 1000 km.

  Future<void> _load(
    Emitter<DonorsState> emit, {
    required double startRadius,
    required int targetCount,
    required bool reset,
    bool refreshOrigin = false,
  }) async {
    final uid = getIt<AuthController>().user?.uid;
    if (uid == null) {
      emit(
        state.copyWith(
          error: 'You need to be signed in.',
          isLoading: false,
          isLoadingMore: false,
        ),
      );
      return;
    }

    // Re-fetch origin on forced refresh or first load.
    if (refreshOrigin || _latitude == null || _longitude == null) {
      final originResult = await _useCase.getOrigin(uid);
      bool ok = true;
      originResult.fold(
        (f) {
          emit(
            state.copyWith(
              error: _msg(f),
              isLoading: false,
              isLoadingMore: false,
            ),
          );
          ok = false;
        },
        (origin) {
          _latitude = origin.latitude;
          _longitude = origin.longitude;
        },
      );
      if (!ok) return;
    }

    // count() reads 0 documents — cached for the BLoC's lifetime.
    if (_totalDonorCount == null) {
      final countResult = await _useCase.getTotalDonorCount();
      countResult.fold((_) {}, (n) => _totalDonorCount = n);
    }

    // Show loading indicator immediately.
    if (reset) {
      emit(
        state.copyWith(
          isLoading: true,
          isLoadingMore: false,
          error: null,
          donors: const <NearbyDonor>[],
          filtered: const <NearbyDonor>[],
          currentRadiusKm: 0,
          hasMore: true,
        ),
      );
    } else {
      emit(state.copyWith(isLoading: false, isLoadingMore: true, error: null));
    }

    // Seed accumulation map from existing donors so load-more never discards.
    final byUid = <String, NearbyDonor>{
      if (!reset)
        for (final d in state.donors) d.uid: d,
    };

    // allLoaded check only applies to "All" — for a specific blood group we
    // don't have a per-group count, so the radius cap terminates the loop.
    final maxDonors =
        (state.selectedBloodGroup == 'All' && _totalDonorCount != null)
        ? _totalDonorCount! - 1
        : null;
    double radius = startRadius;

    while (true) {
      final result = await _useCase.call(
        latitude: _latitude!,
        longitude: _longitude!,
        radiusKm: radius,
        excludeUid: uid,
        bloodGroup: state.selectedBloodGroup == 'All'
            ? null
            : state.selectedBloodGroup,
      );

      bool hadError = false;

      result.fold(
        (f) {
          emit(
            state.copyWith(
              error: _msg(f),
              isLoading: false,
              isLoadingMore: false,
            ),
          );
          hadError = true;
        },
        (fetched) {
          // Merge: each uid's latest result (freshest distance) wins.
          for (final d in fetched) {
            byUid[d.uid] = d;
          }

          final sorted = byUid.values.toList()
            ..sort((a, b) => a.distanceKm.compareTo(b.distanceKm));

          final allLoaded = maxDonors != null && byUid.length >= maxDonors;
          final atMax = radius >= _maxRadiusKm;
          final done = allLoaded || atMax || byUid.length >= targetCount;

          // Emit partial results — UI shows donors live as each radius finishes.
          emit(
            state.copyWith(
              donors: sorted,
              filtered: _applyFilters(state, sorted),
              currentRadiusKm: radius,
              hasMore: !atMax && !allLoaded,
              isLoading: false,
              isLoadingMore: !done,
              error: null,
            ),
          );
        },
      );

      if (hadError) return;

      final allLoaded = maxDonors != null && byUid.length >= maxDonors;
      if (byUid.length >= targetCount || allLoaded || radius >= _maxRadiusKm) {
        break;
      }

      radius = _nextRadius(radius);
    }

    _lastSearchBloodGroup = state.selectedBloodGroup;
    if (byUid.isNotEmpty) {
      await _cacheRadius(radius, state.selectedBloodGroup);
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  static List<NearbyDonor> _applyFilters(
    DonorsState state,
    List<NearbyDonor> donors,
  ) {
    var results = donors;

    final maxDist = _distanceFilterMap[state.selectedDistance];
    if (maxDist != null) {
      results = results.where((d) => d.distanceKm <= maxDist).toList();
    }

    if (state.selectedBloodGroup != 'All') {
      results = results
          .where((d) => d.bloodGroup == state.selectedBloodGroup)
          .toList();
    }

    final q = state.search.toLowerCase().trim();
    if (q.isNotEmpty) {
      results = results
          .where(
            (d) =>
                d.name.toLowerCase().contains(q) ||
                d.thana.toLowerCase().contains(q) ||
                d.district.toLowerCase().contains(q) ||
                d.bloodGroup.toLowerCase().contains(q),
          )
          .toList();
    }

    return results;
  }

  String _msg(Failure f) =>
      f is GeneralFailure ? f.message : 'Something went wrong.';
}
