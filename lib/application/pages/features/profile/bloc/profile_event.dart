import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_event.freezed.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.infoExpandedToggled() = _InfoExpandedToggled;
  const factory ProfileEvent.notificationsToggled() = _NotificationsToggled;
  const factory ProfileEvent.darkModeToggled() = _DarkModeToggled;
  const factory ProfileEvent.quietHoursToggled() = _QuietHoursToggled;
}
