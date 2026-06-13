import 'package:blood_setu/domain/models/chat_source.dart';
import 'package:blood_setu/domain/models/message.dart';
import 'package:blood_setu/domain/models/presence_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_event.freezed.dart';

@freezed
class ChatEvent with _$ChatEvent {
  /// Called when navigating from another screen (no existing conversationId).
  /// The bloc calls getOrCreateConversation then starts watching.
  const factory ChatEvent.openRequested({
    required String currentUid,
    required String otherUid,
    required ChatSource chatSource,
  }) = _OpenRequested;

  const factory ChatEvent.watchStarted({
    required String conversationId,
    required String currentUid,
    required String otherUid,
  }) = _WatchStarted;
  const factory ChatEvent.inputChanged(String value) = _InputChanged;
  const factory ChatEvent.messageSent(String text) = _MessageSent;
  const factory ChatEvent.attachmentToggled() = _AttachmentToggled;
  const factory ChatEvent.attachmentClosed() = _AttachmentClosed;

  // Internal — emitted by stream listeners.
  const factory ChatEvent.messagesReceived(List<Message> messages) =
      _MessagesReceived;
  const factory ChatEvent.presenceChanged(PresenceStatus status) =
      _PresenceChanged;
  const factory ChatEvent.errorOccurred(String message) = _ErrorOccurred;
}
