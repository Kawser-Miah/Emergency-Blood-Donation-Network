import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_request_event.freezed.dart';

@freezed
class CreateRequestEvent with _$CreateRequestEvent {
  const factory CreateRequestEvent.patientNameChanged(String value) = _PatientNameChanged;
  const factory CreateRequestEvent.bloodGroupChanged(String value) = _BloodGroupChanged;
  const factory CreateRequestEvent.unitsIncremented() = _UnitsIncremented;
  const factory CreateRequestEvent.unitsDecremented() = _UnitsDecremented;
  const factory CreateRequestEvent.hospitalChanged(String value) = _HospitalChanged;
  const factory CreateRequestEvent.addressChanged(String value) = _AddressChanged;
  const factory CreateRequestEvent.urgencyChanged(String value) = _UrgencyChanged;
  const factory CreateRequestEvent.needByChanged(DateTime value) = _NeedByChanged;
  const factory CreateRequestEvent.contactChanged(String value) = _ContactChanged;
  const factory CreateRequestEvent.notesChanged(String value) = _NotesChanged;
  const factory CreateRequestEvent.confirmed1Toggled() = _Confirmed1Toggled;
  const factory CreateRequestEvent.confirmed2Toggled() = _Confirmed2Toggled;
  const factory CreateRequestEvent.gpsLocationRequested() = _GpsLocationRequested;
  const factory CreateRequestEvent.requestSubmitted() = _RequestSubmitted;
}
