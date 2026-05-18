import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.initial()) {
    on<ProfileEvent>((event, emit) {
      event.when(
        infoExpandedToggled: () =>
            emit(state.copyWith(infoExpanded: !state.infoExpanded)),
        notificationsToggled: () =>
            emit(state.copyWith(notifications: !state.notifications)),
        darkModeToggled: () =>
            emit(state.copyWith(darkMode: !state.darkMode)),
        quietHoursToggled: () =>
            emit(state.copyWith(quietHours: !state.quietHours)),
      );
    });
  }
}
