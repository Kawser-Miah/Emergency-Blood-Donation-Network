import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../data/mock_data.dart';
import '../../../../../domain/models/chat_message.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    required List<ChatMessage> messages,
    @Default('') String input,
    @Default(false) bool showAttachment,
    @Default(true) bool showTyping,
  }) = _ChatState;

  factory ChatState.initial() => ChatState(messages: List.of(mockMessages));
}
