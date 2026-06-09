import 'package:blood_setu/domain/models/donation_history_entry.dart';
import 'package:blood_setu/domain/models/user_profile_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(false) bool isLoading,
    UserProfileModel? profile,
    @Default(<DonationHistoryEntry>[]) List<DonationHistoryEntry> donationHistory,
    @Default(true) bool infoExpanded,
    @Default(true) bool notifications,
    @Default(false) bool darkMode,
    @Default(true) bool quietHours,
  }) = _ProfileState;

  factory ProfileState.initial() => const ProfileState();
}
