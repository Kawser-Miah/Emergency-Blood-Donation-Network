import 'package:blood_setu/application/core/auth/auth_controller.dart';
import 'package:blood_setu/di/di.dart';
import 'package:blood_setu/domain/usecase/registration_user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/usecase/authentication_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RegistrationUserUseCase _registrationUserUseCase;

  HomeBloc(this._registrationUserUseCase) : super(HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      await event.when(
        started: () async {
          final uid = getIt<AuthController>().user?.uid;
          if (uid == null) return;
          final result = await _registrationUserUseCase.getProfile(uid);
          result.fold(
            (_) {},
            (profile) => emit(state.copyWith(profile: profile)),
          );
        },
        sidebarOpened: () async => emit(state.copyWith(showSidebar: true)),
        sidebarClosed: () async => emit(state.copyWith(showSidebar: false)),
        sosPressed: () async {
          emit(state.copyWith(sosPressed: true));
          await Future.delayed(const Duration(seconds: 2));
          if (!isClosed) add(const HomeEvent.sosReleased());
        },
        sosReleased: () async => emit(state.copyWith(sosPressed: false)),
      );
    });
  }
}
