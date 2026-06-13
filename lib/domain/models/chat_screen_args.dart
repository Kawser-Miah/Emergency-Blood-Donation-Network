import 'chat_contact.dart';
import 'chat_source.dart';
import 'chat_source_type.dart';

class ChatScreenArgs {
  const ChatScreenArgs({
    required this.contact,
    required this.currentUid,
    this.conversationId,
    required this.otherUid,
    ChatSource? chatSource,
  }) : chatSource = chatSource ??
            const ChatSource(type: ChatSourceType.direct);

  final ChatContact contact;
  final String currentUid;
  /// Non-null when navigating from the chat list (conversation already exists).
  final String? conversationId;
  final String otherUid;
  final ChatSource chatSource;
}
