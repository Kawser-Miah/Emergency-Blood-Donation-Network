import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/models/chat_message.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState.initial()) {
    on<ChatEvent>((event, emit) async {
      await event.when(
        inputChanged: (value) async => emit(state.copyWith(input: value)),
        sendRequested: (text) async {
          final trimmed = text.trim();
          if (trimmed.isEmpty) return;
          final newMsg = ChatMessage(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            sent: true,
            text: trimmed,
            time: _formatTime(DateTime.now()),
            read: false,
          );
          emit(state.copyWith(
            messages: [...state.messages, newMsg],
            input: '',
            showTyping: true,
          ));
          await Future.delayed(const Duration(seconds: 2));
          if (!isClosed) add(const ChatEvent.replyArrived());
        },
        attachmentToggled: () async => emit(
          state.copyWith(showAttachment: !state.showAttachment),
        ),
        attachmentClosed: () async =>
            emit(state.copyWith(showAttachment: false)),
        replyArrived: () async {
          final reply = ChatMessage(
            id: '${DateTime.now().millisecondsSinceEpoch + 1}',
            sent: false,
            text:
                "Thanks, I'll be there soon! Which floor is the patient on?",
            time: _formatTime(DateTime.now()),
            read: false,
          );
          emit(state.copyWith(
            showTyping: false,
            messages: [...state.messages, reply],
          ));
        },
      );
    });
  }

  static String _formatTime(DateTime now) {
    final hour12 = now.hour == 0
        ? 12
        : (now.hour > 12 ? now.hour - 12 : now.hour);
    final period = now.hour >= 12 ? 'PM' : 'AM';
    final mm = now.minute.toString().padLeft(2, '0');
    final hh = hour12.toString().padLeft(2, '0');
    return '$hh:$mm $period';
  }
}
