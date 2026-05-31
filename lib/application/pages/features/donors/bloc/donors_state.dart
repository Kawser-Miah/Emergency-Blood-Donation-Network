import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/nearby_donor.dart';

part 'donors_state.freezed.dart';

enum DonorsStatus { initial, loading, loadingMore, success, failure }

@freezed
class DonorsState with _$DonorsState {
  const DonorsState._();

  const factory DonorsState({
    @Default(DonorsStatus.initial) DonorsStatus status,
    @Default(<NearbyDonor>[]) List<NearbyDonor> donors,
    @Default(<NearbyDonor>[]) List<NearbyDonor> filtered,
    @Default(false) bool hasReachedMax,
    @Default(0) int radiusIndex,
    @Default('') String search,
    @Default('All') String selectedBloodGroup,
    @Default('All') String selectedDistance,
    @Default(false) bool showFilters,
    String? errorMessage,
  }) = _DonorsState;

  factory DonorsState.initial() => const DonorsState();

  bool get isInitialLoading => status == DonorsStatus.loading && donors.isEmpty;
  bool get isLoadingMore => status == DonorsStatus.loadingMore;
  bool get hasError => status == DonorsStatus.failure && donors.isEmpty;
}
