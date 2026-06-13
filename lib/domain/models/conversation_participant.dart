import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_participant.freezed.dart';

@freezed
class ConversationParticipant with _$ConversationParticipant {
  const factory ConversationParticipant({
    required String uid,
    required String name,
    required String bloodGroup,
    required String initials,
    required String avatarColor,
    @Default(false) bool online,
    DateTime? lastSeen,
  }) = _ConversationParticipant;

  factory ConversationParticipant.fromMap(Map<String, dynamic> map) =>
      ConversationParticipant(
        uid: map['uid'] as String,
        name: map['name'] as String,
        bloodGroup: map['bloodGroup'] as String,
        initials: map['initials'] as String,
        avatarColor: map['avatarColor'] as String,
        online: map['online'] as bool? ?? false,
        lastSeen: (map['lastSeen'] as Timestamp?)?.toDate(),
      );
}

extension ConversationParticipantX on ConversationParticipant {
  Map<String, dynamic> toMap() => {
        'uid': uid,
        'name': name,
        'bloodGroup': bloodGroup,
        'initials': initials,
        'avatarColor': avatarColor,
        'online': online,
        if (lastSeen != null)
          'lastSeen': Timestamp.fromDate(lastSeen!),
      };
}
