import 'dart:async';

import 'package:blood_setu/application/core/auth/auth_controller.dart';
import 'package:blood_setu/di/di.dart';
import 'package:blood_setu/domain/usecase/location_usecase.dart';
import 'package:blood_setu/domain/usecase/registration_user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'home_event.dart';
import 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RegistrationUserUseCase _registrationUserUseCase;
  final LocationUseCase _locationUseCase;

  HomeBloc(this._registrationUserUseCase, this._locationUseCase)
    : super(HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      await event.when(
        started: () async {
          final uid = getIt<AuthController>().user?.uid;
          if (uid == null) return;

          final result = await _registrationUserUseCase.getProfile(uid);
          result.fold((_) {}, (profile) => emit(state.copyWith(profile: profile)));

          // Fire-and-forget: refresh only GPS coordinates in user_locations.
          unawaited(_locationUseCase.updateGps(uid));
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
