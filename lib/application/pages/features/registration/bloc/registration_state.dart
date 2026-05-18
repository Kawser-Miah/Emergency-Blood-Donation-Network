import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_state.freezed.dart';

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
    @Default(1) int step,
    @Default('Rahmat Ullah') String fullName,
    @Default('') String phone,
    @Default('') String bloodGroup,
    @Default('') String age,
    @Default('') String lastDonation,
    @Default('') String district,
    @Default('') String thana,
    @Default('') String fbId,
    @Default(false) bool confirmed,
  }) = _RegistrationState;

  factory RegistrationState.initial() => const RegistrationState();
}
