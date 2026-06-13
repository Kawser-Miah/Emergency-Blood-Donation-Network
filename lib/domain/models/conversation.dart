import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'chat_source.dart';
import 'conversation_participant.dart';

part 'conversation.freezed.dart';

@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    required String id,
    required List<String> participantIds,
    @Default(<String, ConversationParticipant>{})
    Map<String, ConversationParticipant> participants,
    required String lastMessage,
    required DateTime lastMessageTime,
    required String lastMessageSenderId,
    required Map<String, int> unreadCounts,
    required ChatSource chatSource,
    required DateTime createdAt,
  }) = _Conversation;

  factory Conversation.fromMap(String id, Map<String, dynamic> map) {
    final rawParticipants = map['participants'] as Map<String, dynamic>?;
    return Conversation(
      id: id,
      participantIds: List<String>.from(map['participantIds'] as List),
      participants: rawParticipants != null
          ? rawParticipants.map(
              (k, v) => MapEntry(
                k,
                ConversationParticipant.fromMap(v as Map<String, dynamic>),
              ),
            )
          : const <String, ConversationParticipant>{},
      lastMessage: map['lastMessage'] as String? ?? '',
      lastMessageTime:
          (map['lastMessageTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastMessageSenderId: map['lastMessageSenderId'] as String? ?? '',
      unreadCounts: Map<String, int>.from(
        ((map['unreadCounts'] as Map<String, dynamic>?) ?? {}).map(
          (k, v) => MapEntry(k, (v as num).toInt()),
        ),
      ),
      chatSource:
          ChatSource.fromMap(map['chatSource'] as Map<String, dynamic>),
      createdAt:
          (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
