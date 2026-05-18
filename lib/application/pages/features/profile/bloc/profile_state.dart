import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(true) bool infoExpanded,
    @Default(true) bool notifications,
    @Default(false) bool darkMode,
    @Default(true) bool quietHours,
  }) = _ProfileState;

  factory ProfileState.initial() => const ProfileState();
}
