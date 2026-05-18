import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState.initial()) {
    on<SplashEvent>((event, emit) async {
      await event.when(
        started: () async {
          await Future.delayed(const Duration(seconds: 3));
          if (!isClosed) add(const SplashEvent.timerElapsed());
        },
        timerElapsed: () async {
          emit(state.copyWith(finished: true));
        },
      );
    });
    add(const SplashEvent.started());
  }
}
