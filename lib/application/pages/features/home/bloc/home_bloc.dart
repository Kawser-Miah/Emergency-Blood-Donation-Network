import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      await event.when(
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
