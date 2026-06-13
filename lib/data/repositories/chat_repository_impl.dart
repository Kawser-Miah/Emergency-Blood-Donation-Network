import 'package:blood_setu/domain/models/chat_source.dart';
import 'package:blood_setu/domain/models/conversation.dart';
import 'package:blood_setu/domain/models/conversation_participant.dart';
import 'package:blood_setu/domain/models/message.dart';
import 'package:blood_setu/domain/models/message_status.dart';
import 'package:blood_setu/domain/models/message_type.dart';
import 'package:blood_setu/domain/models/presence_status.dart';
import 'package:blood_setu/domain/repositories/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

const _avatarColors = [
  '#1E88E5',
  '#43A047',
  '#E53935',
  '#FB8C00',
  '#9C27B0',
  '#00ACC1',
  '#F06292',
  '#26A69A',
];

@Injectable(as: IChatRepository)
class ChatRepositoryImpl implements IChatRepository {
  final FirebaseFirestore _firestore;
  final FirebaseDatabase _database;

  ChatRepositoryImpl(this._firestore, this._database);

  CollectionReference<Map<String, dynamic>> get _conversations =>
      _firestore.collection('conversations');

  /// Deterministic ID — avoids duplicate conversations for the same pair.
  String _conversationId(String uid1, String uid2) {
    final sorted = [uid1, uid2]..sort();
    return '${sorted[0]}_${sorted[1]}';
  }

  String _colorFor(String uid) =>
      _avatarColors[uid.hashCode.abs() % _avatarColors.length];

  String _initialsFor(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  ConversationParticipant _participantFromProfile(
    String uid,
    Map<String, dynamic> data,
  ) {
    final name = data['fullName'] as String? ?? '';
    return ConversationParticipant(
      uid: uid,
      name: name,
      bloodGroup: data['bloodGroup'] as String? ?? '',
      initials: _initialsFor(name),
      avatarColor: _colorFor(uid),
    );
  }

  @override
  Future<Conversation> getOrCreateConversation({
    required String currentUid,
    required String otherUid,
    required ChatSource chatSource,
  }) async {
    final convId = _conversationId(currentUid, otherUid);
    final docRef = _conversations.doc(convId);
    final doc = await docRef.get();

    if (doc.exists && doc.data() != null) {
      return Conversation.fromMap(doc.id, doc.data()!);
    }

    final results = await Future.wait([
      _firestore.collection('profile').doc(currentUid).get(),
      _firestore.collection('profile').doc(otherUid).get(),
    ]);
    final myData = results[0].data() ?? {};
    final otherData = results[1].data() ?? {};

    final me = _participantFromProfile(currentUid, myData);
    final other = _participantFromProfile(otherUid, otherData);

    final now = Timestamp.now();
    final data = <String, dynamic>{
      'participantIds': [currentUid, otherUid],
      'participants': {currentUid: me.toMap(), otherUid: other.toMap()},
      'lastMessage': '',
      'lastMessageTime': now,
      'lastMessageSenderId': '',
      'unreadCounts': {currentUid: 0, otherUid: 0},
      'chatSource': chatSource.toMap(),
      'createdAt': now,
    };

    await docRef.set(data);
    return Conversation.fromMap(convId, data);
  }

  @override
  Stream<List<Conversation>> watchConversations(String uid) {
    return _conversations
        .where('participantIds', arrayContains: uid)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => Conversation.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  @override
  Stream<List<Message>> watchMessages(String conversationId) {
    return _conversations
        .doc(conversationId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => Message.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  @override
  Future<void> sendMessage({
    required String conversationId,
    required String senderId,
    required String text,
    required MessageType type,
  }) async {
    final convRef = _conversations.doc(conversationId);
    final msgRef = convRef.collection('messages').doc();
    final now = Timestamp.now();

    final convDoc = await convRef.get();
    final participantIds = List<String>.from(
      convDoc.data()?['participantIds'] as List? ?? [],
    );
    final otherUid = participantIds.firstWhere(
      (id) => id != senderId,
      orElse: () => '',
    );

    final batch = _firestore.batch();

    batch.set(msgRef, {
      'conversationId': conversationId,
      'senderId': senderId,
      'text': text,
      'type': type.toJson(),
      'timestamp': now,
      'readBy': [senderId],
      'status': MessageStatus.sent.toJson(),
    });

    final convUpdate = <String, dynamic>{
      'lastMessage': text,
      'lastMessageTime': now,
      'lastMessageSenderId': senderId,
    };
    if (otherUid.isNotEmpty) {
      convUpdate['unreadCounts.$otherUid'] = FieldValue.increment(1);
    }
    batch.update(convRef, convUpdate);

    await batch.commit();
  }

  @override
  Future<void> markAsRead({
    required String conversationId,
    required String uid,
  }) async {
    try {
      final convRef = _conversations.doc(conversationId);

      await convRef.update({'unreadCounts.$uid': 0});

      // Mark unread messages from others as read (limit to recent 50).
      final unreadSnap = await convRef
          .collection('messages')
          .where('senderId', isNotEqualTo: uid)
          .orderBy('senderId')
          .orderBy('timestamp', descending: true)
          .limit(50)
          .get();

      final toUpdate = unreadSnap.docs.where((doc) {
        final readBy = List<String>.from(doc.data()['readBy'] as List? ?? []);
        return !readBy.contains(uid);
      }).toList();

      if (toUpdate.isEmpty) return;

      final batch = _firestore.batch();
      for (final doc in toUpdate) {
        batch.update(doc.reference, {
          'readBy': FieldValue.arrayUnion([uid]),
          'status': MessageStatus.read.toJson(),
        });
      }
      await batch.commit();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> setOnlineStatus(String uid, bool online) async {
    final ref = _database.ref('presence/$uid');
    if (online) {
      await ref.update({'online': true});
      // RTDB onDisconnect ensures offline is written even on sudden disconnect.
      await ref.onDisconnect().update({
        'online': false,
        'lastSeen': ServerValue.timestamp,
      });
    } else {
      await ref.onDisconnect().cancel();
      await ref.update({'online': false, 'lastSeen': ServerValue.timestamp});
    }
  }

  @override
  Stream<PresenceStatus> watchPresence(String uid) {
    return _database.ref('presence/$uid').onValue.map((event) {
      final data = event.snapshot.value as Map<Object?, Object?>?;
      if (data == null) return const PresenceStatus(online: false);
      final online = data['online'] as bool? ?? false;
      final lastSeenMs = data['lastSeen'] as int?;
      final lastSeen = lastSeenMs != null
          ? DateTime.fromMillisecondsSinceEpoch(lastSeenMs)
          : null;
      return PresenceStatus(online: online, lastSeen: lastSeen);
    });
  }
}
