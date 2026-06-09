import 'package:blood_setu/domain/models/user_profile_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_state.freezed.dart';

enum RegistrationStatus { initial, loading, success, failure }

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
    @Default(false) bool isEditMode,
    @Default(1) int step,
    @Default('') String fullName,
    @Default('') String gender,
    @Default('') String phone,
    @Default('') String bloodGroup,
    @Default('') String age,
    DateTime? lastDonation,
    @Default('') String district,
    @Default('') String thana,
    @Default('') String fbId,
    @Default(false) bool confirmed,
    @Default(RegistrationStatus.initial) RegistrationStatus status,
    @Default('') String errorMessage,
  }) = _RegistrationState;

  factory RegistrationState.initial({String fullName = ''}) =>
      RegistrationState(fullName: fullName);

  factory RegistrationState.fromProfile(UserProfileModel profile) =>
      RegistrationState(
        isEditMode: true,
        fullName: profile.fullName ?? '',
        gender: profile.gender ?? '',
        phone: profile.phone ?? '',
        bloodGroup: profile.bloodGroup ?? '',
        age: profile.age != null ? '${profile.age}' : '',
        lastDonation: profile.lastDonation,
        district: profile.district ?? '',
        thana: profile.thana ?? '',
        fbId: profile.fbId ?? '',
        confirmed: true,
      );
}
