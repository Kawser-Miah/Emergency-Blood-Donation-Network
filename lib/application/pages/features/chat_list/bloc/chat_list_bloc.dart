import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/mock_data.dart';
import 'chat_list_event.dart';
import 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  ChatListBloc() : super(ChatListState.initial()) {
    on<ChatListEvent>((event, emit) {
      event.when(
        searchChanged: (value) {
          final q = value.toLowerCase();
          final filtered = mockChats
              .where((c) => c.name.toLowerCase().contains(q))
              .toList();
          emit(state.copyWith(search: value, chats: filtered));
        },
      );
    });
  }
}
