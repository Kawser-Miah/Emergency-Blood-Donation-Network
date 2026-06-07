import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_requests_event.freezed.dart';

@freezed
class MyRequestsEvent with _$MyRequestsEvent {
  const factory MyRequestsEvent.started() = _Started;
  const factory MyRequestsEvent.refreshed() = _Refreshed;
  const factory MyRequestsEvent.interestedDonorsRequested(
    String requestId,
  ) = _InterestedDonorsRequested;
  const factory MyRequestsEvent.requestUpdated({
    required String id,
    required String patientName,
    required String contact,
    required String hospital,
    required String address,
    required String urgency,
    required int units,
    required DateTime needBy,
    required String notes,
    double? latitude,
    double? longitude,
  }) = _RequestUpdated;
  const factory MyRequestsEvent.requestFulfilled(String id) = _RequestFulfilled;
  const factory MyRequestsEvent.requestDeleted(String id) = _RequestDeleted;
}
