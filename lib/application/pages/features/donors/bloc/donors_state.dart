import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/nearby_donor.dart';

part 'donors_state.freezed.dart';

@freezed
class DonorsState with _$DonorsState {
  const DonorsState._();

  const factory DonorsState({
    @Default(<NearbyDonor>[]) List<NearbyDonor> donors,
    @Default(<NearbyDonor>[]) List<NearbyDonor> filtered,
    @Default(0.0) double currentRadiusKm,
    @Default(true) bool hasMore,
    @Default(true) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default('') String search,
    @Default('All') String selectedBloodGroup,
    @Default('All') String selectedDistance,
    @Default(false) bool showFilters,
    String? error,
  }) = _DonorsState;

  factory DonorsState.initial() => const DonorsState();

  // UI convenience getters.
  bool get isInitialLoading => isLoading && donors.isEmpty;
  bool get hasError => error != null && donors.isEmpty;
  bool get hasFilters =>
      selectedBloodGroup != 'All' ||
      selectedDistance != 'All' ||
      search.isNotEmpty;
}
