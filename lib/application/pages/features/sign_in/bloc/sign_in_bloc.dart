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
          final failureOrSuccess = await _authenticationUseCase
              .signInWithGoogle();
          emit(
            failureOrSuccess.fold(
              (failure) => SignInState.failure(""),
              (_) => const SignInState.success(),
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
