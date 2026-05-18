import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/models/chat_contact.dart';
import '../../../../domain/models/screen.dart';

part 'app_navigation_state.freezed.dart';

@freezed
class AppNavigationState with _$AppNavigationState {
  const factory AppNavigationState({
    required AppScreen screen,
    required ChatContact chatContact,
  }) = _AppNavigationState;

  factory AppNavigationState.initial() => const AppNavigationState(
        screen: AppScreen.splash,
        chatContact: ChatContact(
          name: 'Karim Ahmed',
          bloodGroup: 'O+',
          id: '1',
          initials: 'KA',
          avatarColor: '#1E88E5',
          online: true,
        ),
      );
}
