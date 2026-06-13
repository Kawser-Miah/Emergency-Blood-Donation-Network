import '../models/chat_source.dart';
import '../models/conversation.dart';
import '../models/message.dart';
import '../models/message_type.dart';
import '../models/presence_status.dart';
import '../models/user_profile_model.dart';

abstract class IChatRepository {
  Future<Conversation> getOrCreateConversation({
    required String currentUid,
    required String otherUid,
    required ChatSource chatSource,
  });

  Stream<List<Conversation>> watchConversations(String uid);

  Stream<List<Message>> watchMessages(String conversationId);

  Future<void> sendMessage({
    required String conversationId,
    required String senderId,
    required String text,
    required MessageType type,
  });

  Future<void> markAsRead({
    required String conversationId,
    required String uid,
  });

  Future<void> setOnlineStatus(String uid, bool online);

  /// Streams the presence (online flag + lastSeen) of another user from RTDB.
  Stream<PresenceStatus> watchPresence(String uid);

  /// Fetches fresh profiles for the given UIDs from the profile collection.
  Future<Map<String, UserProfileModel>> fetchProfiles(List<String> uids);
}
