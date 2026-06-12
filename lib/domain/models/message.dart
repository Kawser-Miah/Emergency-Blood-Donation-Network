import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'message_status.dart';
import 'message_type.dart';

part 'message.freezed.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String id,
    required String conversationId,
    required String senderId,
    required String text,
    required MessageType type,
    required DateTime timestamp,
    @Default([]) List<String> readBy,
    required MessageStatus status,
  }) = _Message;

  factory Message.fromMap(String id, Map<String, dynamic> map) => Message(
        id: id,
        conversationId: map['conversationId'] as String,
        senderId: map['senderId'] as String,
        text: map['text'] as String,
        type: MessageType.fromString(map['type'] as String? ?? 'text'),
        timestamp:
            (map['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
        readBy: List<String>.from(map['readBy'] as List? ?? []),
        status: MessageStatus.fromString(map['status'] as String? ?? 'sent'),
      );
}
