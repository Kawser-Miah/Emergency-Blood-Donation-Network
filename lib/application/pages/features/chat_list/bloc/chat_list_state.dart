import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../data/mock_data.dart';
import '../../../../../domain/models/chat_summary.dart';

part 'chat_list_state.freezed.dart';

@freezed
class ChatListState with _$ChatListState {
  const factory ChatListState({
    @Default('') String search,
    required List<ChatSummary> chats,
  }) = _ChatListState;

  factory ChatListState.initial() => ChatListState(chats: List.of(mockChats));
}
