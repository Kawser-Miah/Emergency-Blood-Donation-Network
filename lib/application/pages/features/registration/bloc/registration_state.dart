import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_state.freezed.dart';

enum RegistrationStatus { initial, loading, success, failure }

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
    @Default(1) int step,
    @Default('') String fullName,
    @Default('') String gender,
    @Default('') String phone,
    @Default('') String bloodGroup,
    @Default('') String age,
    @Default('') String lastDonation,
    @Default('') String district,
    @Default('') String thana,
    @Default('') String fbId,
    @Default(false) bool confirmed,
    @Default(RegistrationStatus.initial) RegistrationStatus status,
    @Default('') String errorMessage,
  }) = _RegistrationState;

  factory RegistrationState.initial({String fullName = ''}) =>
      RegistrationState(fullName: fullName);
}
