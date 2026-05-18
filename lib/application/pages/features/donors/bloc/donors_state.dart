import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/donor.dart';

part 'donors_state.freezed.dart';

@freezed
class DonorsState with _$DonorsState {
  const factory DonorsState({
    @Default('') String search,
    @Default('All') String selectedBloodGroup,
    @Default('All') String selectedDistance,
    @Default(0.0) double minRating,
    @Default(false) bool showFilters,
    @Default(<Donor>[]) List<Donor> filtered,
  }) = _DonorsState;

  factory DonorsState.initial() => const DonorsState();
}
