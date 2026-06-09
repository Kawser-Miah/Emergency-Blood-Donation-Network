import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_event.freezed.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.started() = _Started;
  const factory ProfileEvent.infoExpandedToggled() = _InfoExpandedToggled;
  const factory ProfileEvent.notificationsToggled() = _NotificationsToggled;
  const factory ProfileEvent.darkModeToggled() = _DarkModeToggled;
  const factory ProfileEvent.quietHoursToggled() = _QuietHoursToggled;
  const factory ProfileEvent.donationSubmitted({
    required String hospital,
    required String bloodGroup,
    required DateTime date,
  }) = _DonationSubmitted;
}
