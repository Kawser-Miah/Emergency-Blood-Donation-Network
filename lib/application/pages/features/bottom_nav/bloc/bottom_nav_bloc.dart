import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';
part 'bottom_nav_bloc.freezed.dart';

@injectable
class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavState.initial()) {
    on<BottomNavEvent>((event, emit) {
      event.when(
        tabChanged: (index) => emit(state.copyWith(currentIndex: index)),
      );
    });
  }
}
