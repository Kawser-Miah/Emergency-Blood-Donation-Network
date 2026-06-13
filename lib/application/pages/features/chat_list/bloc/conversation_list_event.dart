import 'package:blood_setu/domain/models/conversation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_list_event.freezed.dart';

@freezed
class ConversationListEvent with _$ConversationListEvent {
  const factory ConversationListEvent.watchStarted(String uid) = _WatchStarted;
  const factory ConversationListEvent.searchChanged(String value) =
      _SearchChanged;

  // Internal — emitted by the stream listener.
  const factory ConversationListEvent.conversationsReceived(
    List<Conversation> conversations,
  ) = _ConversationsReceived;
  const factory ConversationListEvent.errorOccurred(String message) =
      _ErrorOccurred;
}
