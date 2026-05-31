import 'package:freezed_annotation/freezed_annotation.dart';

part 'donors_event.freezed.dart';

@freezed
class DonorsEvent with _$DonorsEvent {
  const factory DonorsEvent.started() = _Started;
  const factory DonorsEvent.refreshed() = _Refreshed;
  const factory DonorsEvent.loadMoreRequested() = _LoadMoreRequested;
  const factory DonorsEvent.searchChanged(String value) = _SearchChanged;
  const factory DonorsEvent.bloodGroupSelected(String value) = _BloodGroupSelected;
  const factory DonorsEvent.distanceSelected(String value) = _DistanceSelected;
  const factory DonorsEvent.filtersOpened() = _FiltersOpened;
  const factory DonorsEvent.filtersClosed() = _FiltersClosed;
  const factory DonorsEvent.filtersApplied() = _FiltersApplied;
  const factory DonorsEvent.filtersReset() = _FiltersReset;
}
