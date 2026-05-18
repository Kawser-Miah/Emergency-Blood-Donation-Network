import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/screen.dart';
import 'app_navigation_event.dart';
import 'app_navigation_state.dart';

class AppNavigationBloc extends Bloc<AppNavigationEvent, AppNavigationState> {
  AppNavigationBloc() : super(AppNavigationState.initial()) {
    on<AppNavigationEvent>((event, emit) {
      event.when(
        navigated: (screen, contact) {
          if (screen == AppScreen.chat && contact != null) {
            emit(state.copyWith(screen: screen, chatContact: contact));
          } else {
            emit(state.copyWith(screen: screen));
          }
        },
      );
    });
  }

  bool get canPop {
    final screen = state.screen;
    return screen != AppScreen.splash &&
        screen != AppScreen.signin &&
        screen != AppScreen.home;
  }

  void pop() {
    if (!canPop) return;
    add(AppNavigationEvent.navigated(_parentOf(state.screen)));
  }

  AppScreen _parentOf(AppScreen screen) {
    switch (screen) {
      case AppScreen.register:
        return AppScreen.signin;
      case AppScreen.chat:
        return AppScreen.chats;
      default:
        return AppScreen.home;
    }
  }
}
