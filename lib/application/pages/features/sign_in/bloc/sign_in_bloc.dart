import 'package:blood_setu/application/core/auth/auth_controller.dart';
import 'package:blood_setu/di/di.dart';
import 'package:blood_setu/domain/failures/failures.dart';
import 'package:blood_setu/domain/usecase/authentication_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'sign_in_event.dart';
import 'sign_in_state.dart';

@injectable
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthenticationUseCase _authenticationUseCase;
  SignInBloc({required AuthenticationUseCase authenticationUseCase})
    : _authenticationUseCase = authenticationUseCase,
      super(SignInState.initial()) {
    on<GoogleSignInPressedEvent>((event, emit) async {
      emit(const SignInState.loading());
      try {
        final result = await _authenticationUseCase.signInWithGoogle();

        result.fold(
          (l) {
            if (l is GeneralFailure) {
              emit(SignInState.failure(l.message));
            } else {
              emit(SignInState.failure("Unable to sign in. Please try again."));
            }
          },
          (profileExists) {
            getIt<AuthController>().onLoginSuccess(
              profileExists: profileExists,
            );

            emit(const SignInState.success());
          },
        );
      } catch (e) {
        emit(SignInState.failure("Unable to sign in. Please try again."));
      }
    });

    on<GoogleSignoutEvent>((event, emit) async {
      emit(const SignInState.loading());
      try {
        final result = await _authenticationUseCase.signOut();
        result.fold(
          (failure) {
            if (failure is GeneralFailure) {
              emit(SignInState.failure(failure.message));
            } else {
              emit(
                SignInState.failure("Failed to sign out. Please try again."),
              );
            }
          },
          (r) async {
            await getIt<AuthController>().logout();
            emit(SignInState.signOutSuccess());
          },
        );
      } catch (e) {
        emit(
          SignInState.failure("An unexpected error occurred during sign out."),
        );
      }
    });
  }
}
