import 'package:blood_setu/domain/models/chat_source.dart';
import 'package:blood_setu/domain/models/conversation.dart';
import 'package:blood_setu/domain/models/message.dart';
import 'package:blood_setu/domain/models/message_status.dart';
import 'package:blood_setu/domain/models/message_type.dart';
import 'package:blood_setu/domain/models/presence_status.dart';
import 'package:blood_setu/domain/models/user_profile_model.dart';
import 'package:blood_setu/domain/repositories/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

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

    final now = Timestamp.now();
    final data = <String, dynamic>{
      'participantIds': [currentUid, otherUid],
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

  @override
  Future<Map<String, UserProfileModel>> fetchProfiles(
    List<String> uids,
  ) async {
    if (uids.isEmpty) return {};
    final docs = await Future.wait(
      uids.map((uid) => _firestore.collection('profile').doc(uid).get()),
    );
    final result = <String, UserProfileModel>{};
    for (final doc in docs) {
      if (doc.exists) {
        result[doc.id] = UserProfileModel.fromFirestore(doc);
      }
    }
    return result;
  }

  @override
  Future<void> setTyping({
    required String conversationId,
    required String uid,
    required bool typing,
  }) async {
    final ref = _database.ref('typing/$conversationId/$uid');
    await ref.set(typing);
    if (typing) {
      // Clear on disconnect so a crash never leaves typing stuck on.
      await ref.onDisconnect().set(false);
    } else {
      await ref.onDisconnect().cancel();
    }
  }

  @override
  Stream<bool> watchTyping({
    required String conversationId,
    required String uid,
  }) {
    return _database
        .ref('typing/$conversationId/$uid')
        .onValue
        .map((event) => event.snapshot.value as bool? ?? false);
  }
}
