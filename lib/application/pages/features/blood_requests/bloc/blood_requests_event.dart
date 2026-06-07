import 'package:freezed_annotation/freezed_annotation.dart';

part 'blood_requests_event.freezed.dart';

@freezed
class BloodRequestsEvent with _$BloodRequestsEvent {
  const factory BloodRequestsEvent.started() = _Started;
  const factory BloodRequestsEvent.refreshed() = _Refreshed;
  const factory BloodRequestsEvent.loadMoreRequested() = _LoadMoreRequested;
  const factory BloodRequestsEvent.searchChanged(String value) = _SearchChanged;
  const factory BloodRequestsEvent.bloodGroupSelected(String value) = _BloodGroupSelected;
  const factory BloodRequestsEvent.urgencySelected(String value) = _UrgencySelected;
  const factory BloodRequestsEvent.filtersOpened() = _FiltersOpened;
  const factory BloodRequestsEvent.filtersClosed() = _FiltersClosed;
  const factory BloodRequestsEvent.filtersReset() = _FiltersReset;
  const factory BloodRequestsEvent.imComing(String requestId) = _ImComing;
}
