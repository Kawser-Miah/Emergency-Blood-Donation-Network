import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/user_profile_model.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool showSidebar,
    @Default(false) bool sosPressed,
    UserProfileModel? profile,
  }) = _HomeState;

  factory HomeState.initial() => const HomeState();
}
