import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_event.freezed.dart';

@freezed
class RegistrationEvent with _$RegistrationEvent {
  const factory RegistrationEvent.fullNameChanged(String value) = _FullNameChanged;
  const factory RegistrationEvent.phoneChanged(String value) = _PhoneChanged;
  const factory RegistrationEvent.bloodGroupChanged(String value) = _BloodGroupChanged;
  const factory RegistrationEvent.ageChanged(String value) = _AgeChanged;
  const factory RegistrationEvent.lastDonationChanged(String value) = _LastDonationChanged;
  const factory RegistrationEvent.districtChanged(String value) = _DistrictChanged;
  const factory RegistrationEvent.thanaChanged(String value) = _ThanaChanged;
  const factory RegistrationEvent.fbIdChanged(String value) = _FbIdChanged;
  const factory RegistrationEvent.confirmedToggled() = _ConfirmedToggled;
  const factory RegistrationEvent.nextStep() = _NextStep;
  const factory RegistrationEvent.previousStep() = _PreviousStep;
  const factory RegistrationEvent.registrationSubmitted() = _RegistrationSubmitted;
}
