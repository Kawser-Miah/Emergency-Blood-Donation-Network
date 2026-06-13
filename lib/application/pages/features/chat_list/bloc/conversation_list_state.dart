import 'package:blood_setu/domain/models/conversation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_list_state.freezed.dart';

@freezed
class ConversationListState with _$ConversationListState {
  const factory ConversationListState.loading() = _Loading;
  const factory ConversationListState.loaded({
    required List<Conversation> conversations,
    required List<Conversation> filtered,
    @Default('') String search,
    @Default(0) int totalUnread,
  }) = _Loaded;
  const factory ConversationListState.error(String message) = _Error;
}
