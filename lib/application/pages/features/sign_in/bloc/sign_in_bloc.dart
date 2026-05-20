import 'package:blood_setu/application/core/auth/auth_controller.dart';
import 'package:blood_setu/di/di.dart';
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
    on<SignInEvent>((event, emit) async {
      await event.when(
        googleSignInPressed: () async {
          emit(const SignInState.loading());
          final result = await _authenticationUseCase.signInWithGoogle();
          emit(
            result.fold(
              (failure) => SignInState.failure(""),
              (profileExists) {
                getIt<AuthController>().onLoginSuccess(
                  profileExists: profileExists,
                );
                print("object");
                return const SignInState.success();
              },
            ),
          );
        },
        signOut: () async {
          await _authenticationUseCase.signOut();
          emit(const SignInState.initial());
        },
      );
    });
  }
}
