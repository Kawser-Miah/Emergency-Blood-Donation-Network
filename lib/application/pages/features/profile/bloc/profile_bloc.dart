import 'package:blood_setu/application/core/auth/auth_controller.dart';
import 'package:blood_setu/di/di.dart';
import 'package:blood_setu/domain/usecase/donation_usecase.dart';
import 'package:blood_setu/domain/usecase/registration_user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final DonationUseCase _donationUseCase;
  final RegistrationUserUseCase _registrationUseCase;

  ProfileBloc(this._donationUseCase, this._registrationUseCase)
      : super(ProfileState.initial()) {
    on<ProfileEvent>((event, emit) async {
      await event.when(
        started: () async {
          emit(state.copyWith(isLoading: true));

          final auth = getIt<AuthController>();
          final uid = auth.user?.uid;
          if (uid == null) {
            emit(state.copyWith(isLoading: false));
            return;
          }

          // Use in-memory profile populated by HomeBloc; fall back to Firestore.
          var profile = auth.profile;
          if (profile == null) {
            final result = await _registrationUseCase.getProfile(uid);
            result.fold((_) {}, (p) => profile = p);
          }

          if (profile != null) {
            emit(state.copyWith(profile: profile));
          }

          final historyResult = await _donationUseCase.getDonationHistory(uid);
          historyResult.fold(
            (_) {},
            (history) => emit(state.copyWith(donationHistory: history)),
          );

          emit(state.copyWith(isLoading: false));
        },
        infoExpandedToggled: () async =>
            emit(state.copyWith(infoExpanded: !state.infoExpanded)),
        notificationsToggled: () async =>
            emit(state.copyWith(notifications: !state.notifications)),
        darkModeToggled: () async =>
            emit(state.copyWith(darkMode: !state.darkMode)),
        quietHoursToggled: () async =>
            emit(state.copyWith(quietHours: !state.quietHours)),
      );
    });
  }
}
