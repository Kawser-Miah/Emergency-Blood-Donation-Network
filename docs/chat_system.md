# Blood Setu — Chat System Documentation

## Table of Contents

1. [Overview](#1-overview)
2. [Architecture](#2-architecture)
3. [File Structure](#3-file-structure)
4. [Data Models](#4-data-models)
5. [Firebase Schema](#5-firebase-schema)
6. [Repository Layer](#6-repository-layer)
7. [Use Case Layer](#7-use-case-layer)
8. [BLoC State Management](#8-bloc-state-management)
9. [UI Screens & Widgets](#9-ui-screens--widgets)
10. [Navigation Flow](#10-navigation-flow)
11. [Real-time Features](#11-real-time-features)
12. [Key Algorithms & Patterns](#12-key-algorithms--patterns)
13. [Entry Points](#13-entry-points)

---

## 1. Overview

Blood Setu's chat system is a **1-to-1 real-time messaging** feature that allows blood donors and requesters to communicate directly within the app. It is built on:

- **Firebase Firestore** — persistent message and conversation storage
- **Firebase Realtime Database (RTDB)** — online presence and typing indicators
- **BLoC** — state management for both the conversation list and individual chat
- **GoRouter** — navigation with typed arguments

Every chat is associated with a **source context** (blood request, donor card, etc.) so users always know why a conversation was started.

---

## 2. Architecture

The chat system follows a clean layered architecture:

```
┌─────────────────────────────────────────────────────┐
│                    UI Layer                         │
│  ChatListScreen   ChatScreen   Widgets (Avatar, ...) │
└───────────────────────┬─────────────────────────────┘
                        │ BLoC events / states
┌───────────────────────▼─────────────────────────────┐
│               BLoC / State Layer                    │
│   ConversationListBloc          ChatBloc            │
└───────────────────────┬─────────────────────────────┘
                        │ method calls
┌───────────────────────▼─────────────────────────────┐
│                 Use Case Layer                      │
│                   ChatUseCase                       │
└───────────────────────┬─────────────────────────────┘
                        │ interface
┌───────────────────────▼─────────────────────────────┐
│              Repository / Data Layer                │
│   ChatRepository (interface)                        │
│   ChatRepositoryImpl (Firebase implementation)      │
└───────────────────────┬─────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────┐
│               Firebase Backend                      │
│  Firestore (conversations, messages)                │
│  Realtime Database (presence, typing)               │
└─────────────────────────────────────────────────────┘
```

---

## 3. File Structure

```
lib/
├── domain/
│   ├── models/
│   │   ├── conversation.dart              # Core conversation model
│   │   ├── message.dart                   # Individual message model
│   │   ├── conversation_participant.dart  # Participant snapshot
│   │   ├── chat_source.dart               # Chat origin metadata
│   │   ├── chat_source_type.dart          # Enum: bloodRequest, donorCard, etc.
│   │   ├── chat_contact.dart              # UI-layer contact display model
│   │   ├── chat_screen_args.dart          # Navigation arguments
│   │   ├── presence_status.dart           # Online/lastSeen tracking
│   │   ├── message_type.dart              # Enum: text, image, location, certificate
│   │   └── message_status.dart            # Enum: sending, sent, read
│   ├── repositories/
│   │   └── chat_repository.dart           # Abstract repository interface
│   └── usecase/
│       └── chat_usecase.dart              # Use case methods
│
├── data/
│   └── repositories/
│       └── chat_repository_impl.dart      # Firebase implementation
│
└── application/
    ├── pages/
    │   └── features/
    │       ├── chat/
    │       │   ├── view/
    │       │   │   └── chat_screen.dart           # 1-to-1 chat UI
    │       │   └── bloc/
    │       │       ├── chat_bloc.dart
    │       │       ├── chat_event.dart
    │       │       └── chat_state.dart
    │       └── chat_list/
    │           ├── view/
    │           │   └── chat_list_screen.dart      # Conversation inbox UI
    │           └── bloc/
    │               ├── conversation_list_bloc.dart
    │               ├── conversation_list_event.dart
    │               └── conversation_list_state.dart
    └── core/
        ├── services/
        │   └── routing/
        │       ├── chat_navigation.dart           # navigateToChat() helper
        │       └── app_router.dart                # GoRouter route config
        └── widgets/
            ├── avatar.dart                        # Avatar with online badge
            └── typing_dots.dart                   # Animated typing indicator
```

---

## 4. Data Models

All models use **Freezed** for immutability and union types.

### 4.1 Message

**File:** `lib/domain/models/message.dart`

| Field | Type | Description |
|-------|------|-------------|
| `id` | `String` | Firestore document ID |
| `conversationId` | `String` | Parent conversation ID |
| `senderId` | `String` | UID of the sender |
| `text` | `String` | Message text content |
| `type` | `MessageType` | `text`, `image`, `location`, `certificate` |
| `timestamp` | `DateTime` | When the message was sent |
| `readBy` | `List<String>` | UIDs of users who have read the message |
| `status` | `MessageStatus` | `sending`, `sent`, `read` |

```dart
@freezed
class Message with _$Message {
  const factory Message({
    required String id,
    required String conversationId,
    required String senderId,
    required String text,
    required MessageType type,
    required DateTime timestamp,
    required List<String> readBy,
    required MessageStatus status,
  }) = _Message;
}
```

### 4.2 Conversation

**File:** `lib/domain/models/conversation.dart`

| Field | Type | Description |
|-------|------|-------------|
| `id` | `String` | Deterministic ID: `sorted_uid1_uid2` |
| `participantIds` | `List<String>` | Always exactly 2 UIDs |
| `participants` | `Map<String, ConversationParticipant>` | Snapshot of both users keyed by UID |
| `lastMessage` | `String` | Denormalized for list preview |
| `lastMessageTime` | `DateTime` | For sorting inbox list |
| `lastMessageSenderId` | `String` | Used to display "You: …" prefix |
| `unreadCounts` | `Map<String, int>` | e.g. `{ "uid1": 0, "uid2": 2 }` |
| `chatSource` | `ChatSource` | Context/origin of the conversation |
| `createdAt` | `DateTime` | When conversation was first created |

### 4.3 ConversationParticipant

**File:** `lib/domain/models/conversation_participant.dart`

| Field | Type | Description |
|-------|------|-------------|
| `uid` | `String` | User UID |
| `name` | `String` | Display name |
| `bloodGroup` | `String` | Blood group (e.g. `A+`) |
| `initials` | `String` | Generated from name (e.g. `KM`) |
| `avatarColor` | `String` | Hex color string (e.g. `#1E88E5`) |
| `online` | `bool` | Real-time online status from RTDB |
| `lastSeen` | `DateTime?` | Last time the user was online |

### 4.4 ChatSource

**File:** `lib/domain/models/chat_source.dart`

| Field | Type | Description |
|-------|------|-------------|
| `type` | `ChatSourceType` | Origin of the chat |
| `referenceId` | `String?` | Optional ID of related document |

**ChatSourceType** values:
- `bloodRequest` — initiated from a blood request card
- `donorCard` — initiated from a donor profile/card
- `interestResponse` — initiated from an interest/response action
- `direct` — initiated directly without a context reference

### 4.5 ChatSource (Navigation Args)

**File:** `lib/domain/models/chat_screen_args.dart`

Passed via GoRouter's `extra` parameter when navigating to chat:

| Field | Type | Description |
|-------|------|-------------|
| `currentUid` | `String` | Logged-in user's UID |
| `otherUid` | `String` | The other participant's UID |
| `otherName` | `String` | Other user's name (for AppBar) |
| `otherBloodGroup` | `String` | Other user's blood group |
| `otherAvatarColor` | `String` | Hex color for avatar |
| `otherInitials` | `String` | Initials for avatar fallback |
| `otherPhotoUrl` | `String?` | Optional profile photo URL |
| `chatSource` | `ChatSource` | Why this chat was started |
| `conversationId` | `String?` | Pre-existing conversation ID (from inbox tap) |

### 4.6 PresenceStatus

**File:** `lib/domain/models/presence_status.dart`

| Field | Type | Description |
|-------|------|-------------|
| `online` | `bool` | Whether user is currently online |
| `lastSeen` | `DateTime?` | Last time user was active |

### 4.7 Enums

**MessageType** (`lib/domain/models/message_type.dart`):
- `text` — plain text message
- `image` — image attachment
- `location` — location pin
- `certificate` — blood donation certificate

**MessageStatus** (`lib/domain/models/message_status.dart`):
- `sending` — optimistic local state, not yet written to Firestore
- `sent` — successfully written to Firestore
- `read` — read by the other participant

---

## 5. Firebase Schema

### 5.1 Firestore

```
conversations/
  └── {conversationId}                    ← e.g. "alice_bob" (UIDs sorted alphabetically)
        ├── participantIds: ["alice", "bob"]
        ├── participants: {
        │     "alice": {
        │       uid: "alice",
        │       name: "Alice Smith",
        │       bloodGroup: "A+",
        │       initials: "AS",
        │       avatarColor: "#1E88E5",
        │       online: true,
        │       lastSeen: <Timestamp>
        │     },
        │     "bob": { ... }
        │   }
        ├── lastMessage: "I'll be there in 30 min"
        ├── lastMessageTime: <Timestamp>
        ├── lastMessageSenderId: "alice"
        ├── unreadCounts: { "alice": 0, "bob": 2 }
        ├── chatSource: { type: "blood_request", referenceId: "req_xyz" }
        ├── createdAt: <Timestamp>
        └── messages/
              └── {messageId}
                    ├── conversationId: "alice_bob"
                    ├── senderId: "alice"
                    ├── text: "On my way"
                    ├── type: "text"
                    ├── timestamp: <Timestamp>
                    ├── readBy: ["alice", "bob"]
                    └── status: "read"
```

**Firestore Indexes required:**
- `conversations` — `participantIds` (array-contains) + `lastMessageTime` (descending)

### 5.2 Firebase Realtime Database

```
/presence/
  └── {uid}
        ├── online: true
        └── lastSeen: <ServerTimestamp>

/typing/
  └── {conversationId}/
        └── {uid}: true
```

The RTDB is used for low-latency, ephemeral state (presence + typing) that does not need the durability of Firestore.

---

## 6. Repository Layer

### 6.1 Interface

**File:** `lib/domain/repositories/chat_repository.dart`

```dart
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

  /// Writes the current user's typing status for a conversation to RTDB.
  Future<void> setTyping({
    required String conversationId,
    required String uid,
    required bool typing,
  });

  /// Streams whether another user is typing in a conversation from RTDB.
  Stream<bool> watchTyping({
    required String conversationId,
    required String uid,
  });
}
```

### 6.2 Implementation

**File:** `lib/data/repositories/chat_repository_impl.dart`

```dart
@Injectable(as: IChatRepository)
class ChatRepositoryImpl implements IChatRepository {
  final FirebaseFirestore _firestore;
  final FirebaseDatabase _database;

  ChatRepositoryImpl(this._firestore, this._database);

  CollectionReference<Map<String, dynamic>> get _conversations =>
      _firestore.collection('conversations');
}
```

#### Deterministic Conversation ID Helper

```dart
/// Sorts UIDs so "alice_bob" and "bob_alice" always resolve to the same doc.
String _conversationId(String uid1, String uid2) {
  final sorted = [uid1, uid2]..sort();
  return '${sorted[0]}_${sorted[1]}';
}
```

#### `getOrCreateConversation()`

```dart
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
```

#### `watchConversations()` — Firestore Stream

```dart
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
```

#### `watchMessages()` — Firestore Subcollection Stream

```dart
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
```

#### `sendMessage()` — Atomic Batch Write

```dart
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

  // Write new message to subcollection.
  batch.set(msgRef, {
    'conversationId': conversationId,
    'senderId': senderId,
    'text': text,
    'type': type.toJson(),
    'timestamp': now,
    'readBy': [senderId],
    'status': MessageStatus.sent.toJson(),
  });

  // Update conversation metadata atomically.
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
```

#### `markAsRead()` — Batch Read Reset

```dart
@override
Future<void> markAsRead({
  required String conversationId,
  required String uid,
}) async {
  try {
    final convRef = _conversations.doc(conversationId);

    // Reset unread badge counter.
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
```

#### `setOnlineStatus()` — RTDB with onDisconnect Hook

```dart
@override
Future<void> setOnlineStatus(String uid, bool online) async {
  final ref = _database.ref('presence/$uid');
  if (online) {
    await ref.update({'online': true});
    // onDisconnect ensures offline is written even on sudden disconnect/crash.
    await ref.onDisconnect().update({
      'online': false,
      'lastSeen': ServerValue.timestamp,
    });
  } else {
    await ref.onDisconnect().cancel();
    await ref.update({'online': false, 'lastSeen': ServerValue.timestamp});
  }
}
```

#### `watchPresence()` — RTDB Stream

```dart
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
```

#### `setTyping()` — RTDB with onDisconnect Hook

```dart
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
```

#### `watchTyping()` — RTDB Stream

```dart
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
```

#### `fetchProfiles()` — Parallel Firestore Reads

```dart
@override
Future<Map<String, UserProfileModel>> fetchProfiles(List<String> uids) async {
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
```

---

## 7. Use Case Layer

**File:** `lib/domain/usecase/chat_usecase.dart`

`ChatUseCase` wraps the repository and is injected into both BLoCs. Future-returning methods are wrapped with `Either<Failure, T>` (from `dartz`) so BLoCs can handle errors declaratively. Stream pass-throughs require no wrapping.

```dart
@injectable
class ChatUseCase {
  final IChatRepository _repository;

  ChatUseCase(this._repository);

  // --- Future methods: wrapped with Either ---

  Future<Either<Failure, Conversation>> getOrCreateConversation({
    required String currentUid,
    required String otherUid,
    required ChatSource chatSource,
  }) async {
    try {
      final conv = await _repository.getOrCreateConversation(
        currentUid: currentUid,
        otherUid: otherUid,
        chatSource: chatSource,
      );
      return Right(conv);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> sendMessage({
    required String conversationId,
    required String senderId,
    required String text,
    required MessageType type,
  }) async {
    try {
      await _repository.sendMessage(
        conversationId: conversationId,
        senderId: senderId,
        text: text,
        type: type,
      );
      return const Right(null);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> markAsRead({
    required String conversationId,
    required String uid,
  }) async {
    try {
      await _repository.markAsRead(conversationId: conversationId, uid: uid);
      return const Right(null);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> setOnlineStatus(String uid, bool online) async {
    try {
      await _repository.setOnlineStatus(uid, online);
      return const Right(null);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  Future<Map<String, UserProfileModel>> fetchProfiles(List<String> uids) =>
      _repository.fetchProfiles(uids);

  Future<void> setTyping({
    required String conversationId,
    required String uid,
    required bool typing,
  }) => _repository.setTyping(
        conversationId: conversationId,
        uid: uid,
        typing: typing,
      );

  // --- Stream pass-throughs: no Either wrapping needed ---

  Stream<List<Conversation>> watchConversations(String uid) =>
      _repository.watchConversations(uid);

  Stream<List<Message>> watchMessages(String conversationId) =>
      _repository.watchMessages(conversationId);

  Stream<PresenceStatus> watchPresence(String uid) =>
      _repository.watchPresence(uid);

  Stream<bool> watchTyping({
    required String conversationId,
    required String uid,
  }) => _repository.watchTyping(conversationId: conversationId, uid: uid);
}
```

---

## 8. BLoC State Management

### 8.1 ConversationListBloc

**Files:**
- `lib/application/pages/features/chat_list/bloc/conversation_list_bloc.dart`
- `lib/application/pages/features/chat_list/bloc/conversation_list_event.dart`
- `lib/application/pages/features/chat_list/bloc/conversation_list_state.dart`

#### Events

| Event | Payload | Description |
|-------|---------|-------------|
| `watchStarted` | `uid: String` | Begin watching conversations for current user |
| `searchChanged` | `value: String` | Filter the conversation list |
| `conversationsReceived` | `List<Conversation>` | Internal: stream emitted new data |
| `profilesFetched` | `Map<String, UserProfileModel>` | Internal: profiles loaded for participants |
| `errorOccurred` | `message: String` | Something went wrong |

#### States

```
ConversationListState
  ├── loading()
  ├── loaded({
  │     conversations: List<Conversation>,   // all conversations
  │     filtered: List<Conversation>,        // search-filtered subset
  │     search: String,                      // current search query
  │     totalUnread: int,                    // badge count for tab
  │     profiles: Map<String, UserProfileModel>
  │   })
  └── error(message: String)
```

#### Events (Freezed)

```dart
@freezed
class ConversationListEvent with _$ConversationListEvent {
  const factory ConversationListEvent.watchStarted(String uid) = _WatchStarted;
  const factory ConversationListEvent.searchChanged(String value) = _SearchChanged;

  // Internal — emitted by the stream listener.
  const factory ConversationListEvent.conversationsReceived(
    List<Conversation> conversations,
  ) = _ConversationsReceived;
  const factory ConversationListEvent.errorOccurred(String message) = _ErrorOccurred;

  // Internal — emitted after profiles are fetched from Firestore.
  const factory ConversationListEvent.profilesFetched(
    Map<String, UserProfileModel> profiles,
  ) = _ProfilesFetched;
}
```

#### States (Freezed)

```dart
@freezed
class ConversationListState with _$ConversationListState {
  const factory ConversationListState.loading() = _Loading;
  const factory ConversationListState.loaded({
    required List<Conversation> conversations,
    required List<Conversation> filtered,
    @Default('') String search,
    @Default(0) int totalUnread,
    @Default(<String, UserProfileModel>{}) Map<String, UserProfileModel> profiles,
  }) = _Loaded;
  const factory ConversationListState.error(String message) = _Error;
}
```

#### Key Implementation

**Stream setup — `_startWatching()`:**
```dart
void _startWatching(String uid) {
  _currentUid = uid;
  _refreshProfiles = true;
  _sub?.cancel();
  _sub = _useCase.watchConversations(uid).listen(
    (conversations) =>
        add(ConversationListEvent.conversationsReceived(conversations)),
    onError: (Object e) =>
        add(ConversationListEvent.errorOccurred(e.toString())),
  );
}
```

**Stream handler — `_emitLoaded()`** (profile cache + unread sum + incremental fetch):
```dart
void _emitLoaded(List<Conversation> all, Emitter<ConversationListState> emit) {
  final existing = state.maybeMap(loaded: (s) => s, orElse: () => null);
  final search = existing?.search ?? '';

  // Discard stale profile cache when watchStarted fires.
  final profiles = _refreshProfiles
      ? const <String, UserProfileModel>{}
      : (existing?.profiles ?? const <String, UserProfileModel>{});
  _refreshProfiles = false;

  final filtered = _filter(all, search, _currentUid, profiles);
  final totalUnread = all.fold<int>(
    0,
    (sum, c) => sum + (c.unreadCounts[_currentUid] ?? 0),
  );
  emit(
    ConversationListState.loaded(
      conversations: all,
      filtered: filtered,
      search: search,
      totalUnread: totalUnread,
      profiles: profiles,
    ),
  );

  // Only fetch profiles for UIDs not already cached.
  final knownUids = profiles.keys.toSet();
  final uidsToFetch = all
      .expand((c) => c.participantIds.where((id) => id != _currentUid))
      .toSet()
      .difference(knownUids)
      .toList();
  if (uidsToFetch.isNotEmpty) {
    _useCase.fetchProfiles(uidsToFetch).then(
      (fetched) => add(ConversationListEvent.profilesFetched(fetched)),
    );
  }
}
```

**Profile merge — `_mergeProfiles()`:**
```dart
void _mergeProfiles(
  Map<String, UserProfileModel> incoming,
  Emitter<ConversationListState> emit,
) {
  state.maybeMap(
    loaded: (s) {
      final merged = {...s.profiles, ...incoming};
      final filtered = _filter(s.conversations, s.search, _currentUid, merged);
      emit(s.copyWith(profiles: merged, filtered: filtered));
    },
    orElse: () {},
  );
}
```

**Search filter — `_filter()` (static):**
```dart
static List<Conversation> _filter(
  List<Conversation> all,
  String query,
  String currentUid,
  Map<String, UserProfileModel> profiles,
) {
  if (query.isEmpty) return all;
  final q = query.toLowerCase();
  return all.where((c) {
    final otherUid = c.participantIds.firstWhere(
      (id) => id != currentUid,
      orElse: () => '',
    );
    final profile = profiles[otherUid];
    if (profile != null) {
      return (profile.fullName ?? '').toLowerCase().contains(q) ||
          (profile.bloodGroup ?? '').toLowerCase().contains(q);
    }
    // Fall back to stored participant data while profile is still loading.
    return c.participants.values.any(
      (p) =>
          p.name.toLowerCase().contains(q) ||
          p.bloodGroup.toLowerCase().contains(q),
    );
  }).toList();
}
```

### 8.2 ChatBloc

**Files:**
- `lib/application/pages/features/chat/bloc/chat_bloc.dart`
- `lib/application/pages/features/chat/bloc/chat_event.dart`
- `lib/application/pages/features/chat/bloc/chat_state.dart`

#### Events

| Event | Payload | Description |
|-------|---------|-------------|
| `openRequested` | `currentUid, otherUid, chatSource` | New chat initiated from another screen |
| `watchStarted` | `conversationId, currentUid, otherUid` | Watch an existing conversation |
| `inputChanged` | `value: String` | User is typing in the input field |
| `messageSent` | `text: String` | Send button tapped |
| `attachmentToggled` | — | Show/hide attachment options sheet |
| `attachmentClosed` | — | Close the attachment sheet |
| `messagesReceived` | `List<Message>` | Internal: stream update from Firestore |
| `presenceChanged` | `PresenceStatus` | Internal: other user's online status changed |
| `typingChanged` | `bool` | Internal: other user's typing status changed |
| `errorOccurred` | `message: String` | Error occurred |

#### States

```
ChatState
  ├── loading()
  ├── ready({
  │     messages: List<Message>,       // all messages, oldest first
  │     input: String,                 // current text field value
  │     showAttachment: bool,          // attachment sheet visibility
  │     showTyping: bool,              // other user is typing
  │     otherOnline: bool,             // other user's online status
  │     otherLastSeen: DateTime?       // other user's last seen time
  │   })
  └── error(message: String)
```

#### Events (Freezed)

```dart
@freezed
class ChatEvent with _$ChatEvent {
  /// Called when navigating from another screen (no existing conversationId).
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
  const factory ChatEvent.messagesReceived(List<Message> messages) = _MessagesReceived;
  const factory ChatEvent.presenceChanged(PresenceStatus status) = _PresenceChanged;
  const factory ChatEvent.typingChanged(bool isTyping) = _TypingChanged;
  const factory ChatEvent.errorOccurred(String message) = _ErrorOccurred;
}
```

#### States (Freezed)

```dart
@freezed
class ChatState with _$ChatState {
  const factory ChatState.loading() = _Loading;
  const factory ChatState.ready({
    required List<Message> messages,
    @Default('') String input,
    @Default(false) bool showAttachment,
    @Default(false) bool showTyping,
    @Default(false) bool otherOnline,
    DateTime? otherLastSeen,
  }) = _Ready;
  const factory ChatState.error(String message) = _Error;
}
```

#### Key Implementation

**All 3 stream subscriptions wired up — `_startWatching()`:**
```dart
void _startWatching(String conversationId, String currentUid, String otherUid) {
  _conversationId = conversationId;
  _currentUid = currentUid;
  _otherUid = otherUid;

  // Mark as read immediately on open — fire-and-forget.
  _useCase.markAsRead(conversationId: _conversationId, uid: _currentUid);

  // Announce current user as online; RTDB onDisconnect handles going offline.
  _useCase.setOnlineStatus(_currentUid, true).then(
    (result) => result.fold(
      (f) => add(ChatEvent.errorOccurred(
        f is GeneralFailure ? f.message : 'Presence error',
      )),
      (_) {},
    ),
  );

  // Watch the other participant's presence.
  _presenceSub?.cancel();
  _presenceSub = _useCase
      .watchPresence(_otherUid)
      .listen(
        (status) => add(ChatEvent.presenceChanged(status)),
        onError: (e) => debugPrint('Presence watch error: $e'),
      );

  // Watch the other participant's typing status.
  _typingSub?.cancel();
  _typingSub = _useCase
      .watchTyping(conversationId: _conversationId, uid: _otherUid)
      .listen(
        (isTyping) => add(ChatEvent.typingChanged(isTyping)),
        onError: (e) => debugPrint('Typing watch error: $e'),
      );

  // Watch messages.
  _sub?.cancel();
  _sub = _useCase
      .watchMessages(_conversationId)
      .listen(
        (messages) => add(ChatEvent.messagesReceived(messages)),
        onError: (Object e) => add(ChatEvent.errorOccurred(e.toString())),
      );
}
```

**Typing idle timer — `_handleTypingUpdate()` and `_clearTyping()`:**
```dart
void _handleTypingUpdate(String value) {
  if (value.isEmpty) {
    _clearTyping();
    return;
  }

  // Restart the 5-second idle timer on every keystroke.
  _typingTimer?.cancel();
  _typingTimer = Timer(const Duration(seconds: 5), _clearTyping);

  // Only write to RTDB if not already flagged as typing (avoids redundant writes).
  if (!_isTyping) {
    _isTyping = true;
    _useCase.setTyping(
      conversationId: _conversationId,
      uid: _currentUid,
      typing: true,
    );
  }
}

void _clearTyping() {
  _typingTimer?.cancel();
  _typingTimer = null;
  if (_isTyping) {
    _isTyping = false;
    _useCase.setTyping(
      conversationId: _conversationId,
      uid: _currentUid,
      typing: false,
    );
  }
}
```

**Optimistic send + rollback on failure — `_sendMessage()`:**
```dart
Future<void> _sendMessage(String text, Emitter<ChatState> emit) async {
  final trimmed = text.trim();
  if (trimmed.isEmpty) return;

  final current = state.maybeMap(ready: (s) => s, orElse: () => null);
  if (current == null) return;

  _clearTyping();

  // Optimistic: add message locally before the Firestore write.
  final optimistic = Message(
    id: 'tmp_${DateTime.now().millisecondsSinceEpoch}',
    conversationId: _conversationId,
    senderId: _currentUid,
    text: trimmed,
    type: MessageType.text,
    timestamp: DateTime.now(),
    readBy: [_currentUid],
    status: MessageStatus.sending,
  );

  emit(current.copyWith(
    messages: [...current.messages, optimistic],
    input: '',
    showAttachment: false,
  ));

  final result = await _useCase.sendMessage(
    conversationId: _conversationId,
    senderId: _currentUid,
    text: trimmed,
    type: MessageType.text,
  );
  result.fold(
    (f) {
      // Remove the stuck optimistic message on failure.
      final s = state.maybeMap(ready: (s) => s, orElse: () => null);
      if (s != null) {
        emit(s.copyWith(
          messages: s.messages.where((m) => m.id != optimistic.id).toList(),
        ));
      }
    },
    (_) {}, // Success: Firestore stream replaces the optimistic entry.
  );
}
```

**Cleanup on dispose — `close()`:**
```dart
@override
Future<void> close() async {
  _sub?.cancel();
  _presenceSub?.cancel();
  _typingSub?.cancel();
  _clearTyping();
  // Mark offline when leaving the chat screen.
  if (_currentUid.isNotEmpty) {
    await _useCase.setOnlineStatus(_currentUid, false);
  }
  return super.close();
}
```

---

## 9. UI Screens & Widgets

### 9.1 ChatListScreen

**File:** `lib/application/pages/features/chat_list/view/chat_list_screen.dart`

The inbox view showing all conversations.

**Layout:**
```
Scaffold
  ├── AppBar: "Messages" title + search bar
  └── Body:
        ├── [loading] → CircularProgressIndicator
        ├── [loaded, empty] → Empty state with "Find Donors" CTA
        └── [loaded, has conversations] → ListView of _ChatRow
```

**`_ChatRow` widget (conversation list item):**
- **Left:** Avatar with online indicator (green dot overlay)
- **Center:**
  - Top row: participant name + blood group badge
  - Bottom row: last message preview ("You: …" prefix if sent by current user)
- **Right:**
  - Timestamp (time today, "Yesterday", or date)
  - Unread badge (red circle with count) if `unreadCount > 0`

### 9.2 ChatScreen

**File:** `lib/application/pages/features/chat/view/chat_screen.dart`

The 1-to-1 chat interface.

**Layout:**
```
Scaffold
  ├── _AppBar
  │     ├── Avatar (photo or initials + color)
  │     ├── Name + blood group badge
  │     ├── Online status: "Online" | "Last seen X ago"
  │     └── Menu icon (kebab)
  └── Body:
        ├── Message list (reversed ListView for bottom-up scroll)
        │     ├── Date separators ("Today", "Yesterday", "Monday", "Jun 12")
        │     ├── _Bubble (sent/received)
        │     └── _TypingRow (shown when other user is typing)
        ├── _QuickReplies (horizontal scroll, shown when messages are empty)
        └── _InputBar
              ├── Attachment button
              ├── Multiline TextField (with emoji button)
              └── Send button (animated: grey → blue when text present)
```

**`_Bubble` widget (message bubble):**
- Sent messages: right-aligned, blue background (`Colors.blue.shade600`)
- Received messages: left-aligned, grey background (`Colors.grey.shade200`)
- Lower corner on the opposite side is squared (visual tail effect)
- Bottom row shows timestamp + read status:
  - `⏳` — `sending`
  - `✓` — `sent`
  - `✓✓` (blue) — `read`

**`_TypingRow` widget:**
- Shows receiver's avatar on the left
- Shows `TypingBubble` (animated 3 dots in a speech bubble)

**`_QuickReplies` widget:**
- Horizontal row of pill-shaped tap targets
- Predefined responses (e.g. "I'm available", "Where are you?")
- Visible only when no messages exist yet

**`_AttachmentSheet` widget:**
- Bottom sheet with a 2×2 grid
- Options: Camera, Gallery, Location, Certificate

**`_InputBar` widget:**
- Multiline text field that grows up to 4 lines
- Send button animates color change (grey → blue) when text is non-empty
- Attachment icon on the left opens `_AttachmentSheet`

### 9.3 Shared Widgets

**Avatar** (`lib/application/core/widgets/avatar.dart`):
- Displays a circular avatar
- Falls back to colored circle with initials if no photo URL
- Supports an optional green online indicator badge (bottom-right overlay)

**TypingDotsList / TypingBubble** (`lib/application/core/widgets/typing_dots.dart`):
- `TypingDotsList`: Three animated dots that bounce in sequence
- `TypingBubble`: Wraps `TypingDotsList` in a speech-bubble container

---

## 10. Navigation Flow

### 10.1 Route Configuration

**File:** `lib/application/core/services/routing/app_router.dart`

```dart
GoRoute(
  path: PAGES.chat.screenPath,
  name: PAGES.chat.screenName,
  builder: (context, state) {
    final args = state.extra as ChatScreenArgs;
    return ChatScreen(args: args);
  },
)
```

### 10.2 `navigateToChat()` Helper

**File:** `lib/application/core/services/routing/chat_navigation.dart`

A utility function that handles all the boilerplate before pushing the chat route:

```dart
void navigateToChat({
  required BuildContext context,
  required String currentUid,
  required String otherUid,
  required String otherName,
  required String otherBloodGroup,
  required ChatSource chatSource,
  String? otherPhotoUrl,
  String? conversationId,       // if coming from the inbox (conversation already exists)
})
```

**Helper functions within the file:**
- `chatAvatarColor(uid)` — Maps UID hashcode to one of 8 predefined colors deterministically
- `chatInitials(name)` — Extracts first letter of each word in the name (e.g. `"Kawser Miah"` → `"KM"`)

### 10.3 Entry Points

| Source | ChatSourceType | Where in code |
|--------|---------------|---------------|
| Donor card (HomeScreen) | `donorCard` | `HomeScreen` donor `onMessage` callback |
| Blood request card | `bloodRequest` | `HomeScreen` blood request `onMessage` callback |
| Donor details bottom sheet | `donorCard` | `DonorDetailsSheet` message button |
| Chat inbox list | *(existing conversation)* | `ChatListScreen` `_ChatRow` tap |

---

## 11. Real-time Features

### 11.1 Online Presence

- Stored in **Firebase Realtime Database** (not Firestore) for lower latency and built-in connection state
- Written to `/presence/{uid}` on app open / chat open
- `onDisconnect()` hook guarantees the user is marked offline even if the app is killed
- The other user's presence is watched as a stream and reflected in the AppBar subtitle

### 11.2 Typing Indicators

- Stored in RTDB at `/typing/{conversationId}/{uid}`
- Set to `true` on every keystroke
- A **5-second idle timer** resets on each keystroke; when it fires, sets typing to `false`
- Cleared on disconnect via `onDisconnect().remove()`
- The other user's typing state drives `showTyping` in `ChatState.ready`

### 11.3 Unread Counts

- Stored in the conversation document as `unreadCounts: { uid: count }`
- Incremented by 1 for the recipient in the same batch write as the message send
- Reset to 0 when the recipient opens the conversation (`markAsRead`)
- `ConversationListBloc` sums all unread counts for the current user → `totalUnread` for tab badge

### 11.4 Message Read Receipts

- Each message has a `readBy: List<String>` field
- `markAsRead()` adds the current user's UID to `readBy` on recent unread messages (batch, up to 50)
- The `MessageStatus` displayed in the bubble derives from whether `readBy` contains the other user's UID

---

## 12. Key Algorithms & Patterns

### 12.1 Deterministic Conversation ID

Prevents duplicate conversation documents for the same two users:

```dart
// In ChatRepositoryImpl
String _conversationId(String uid1, String uid2) {
  final sorted = [uid1, uid2]..sort();
  return '${sorted[0]}_${sorted[1]}';
}
```

Regardless of who opens the chat first, `alice_bob` always refers to the same conversation.

### 12.2 Optimistic UI Updates

To make the app feel instant, sent messages appear in the UI immediately before Firestore confirms the write:

1. Create a local `Message` with `status: sending` and a temporary ID
2. Prepend it to the state's message list
3. Write to Firestore in the background
4. When the Firestore stream fires, the real message (with `status: sent`) replaces the optimistic one
5. On write failure, remove the optimistic message from the list

### 12.3 Search / Filter

`ConversationListBloc` applies a case-insensitive contains filter across participant `name` and `bloodGroup` whenever `searchChanged` is dispatched. The filtered list is kept separately from the full list so resetting the search is instant.

### 12.4 Profile Caching

The `ConversationListBloc` maintains a `Map<String, UserProfileModel>` cache. On each conversation stream update, it only fetches profiles for UIDs that aren't already in the cache. This prevents redundant Firestore reads on every real-time update.

### 12.5 Typing Idle Timer

The BLoC tracks a `bool _isTyping` flag to avoid redundant RTDB writes on every keystroke:

```dart
// In ChatBloc
Timer? _typingTimer;
bool _isTyping = false;

void _handleTypingUpdate(String value) {
  if (value.isEmpty) { _clearTyping(); return; }

  _typingTimer?.cancel();
  _typingTimer = Timer(const Duration(seconds: 5), _clearTyping);

  if (!_isTyping) {
    _isTyping = true;
    _useCase.setTyping(conversationId: _conversationId, uid: _currentUid, typing: true);
  }
}

void _clearTyping() {
  _typingTimer?.cancel();
  _typingTimer = null;
  if (_isTyping) {
    _isTyping = false;
    _useCase.setTyping(conversationId: _conversationId, uid: _currentUid, typing: false);
  }
}
```

---

## 13. Entry Points

### Initiating a New Chat

From any screen, call `navigateToChat()`:

```dart
navigateToChat(
  context: context,
  currentUid: currentUser.uid,
  otherUid: donor.uid,
  otherName: donor.name,
  otherBloodGroup: donor.bloodGroup,
  chatSource: const ChatSource(type: ChatSourceType.donorCard),
  otherPhotoUrl: donor.photoUrl,
);
```

### Opening an Existing Conversation

From `ChatListScreen`, tap a `_ChatRow`:

```dart
navigateToChat(
  context: context,
  currentUid: currentUser.uid,
  otherUid: otherParticipantUid,
  otherName: otherParticipantName,
  otherBloodGroup: otherParticipantBloodGroup,
  chatSource: conversation.chatSource,
  conversationId: conversation.id,   // ← skips getOrCreate, goes straight to watchStarted
);
```

When `conversationId` is provided in `ChatScreenArgs`, the `ChatBloc` dispatches `watchStarted` directly instead of `openRequested`, avoiding a redundant Firestore read.

---

*Generated: 2026-06-14 | Blood Setu v1.x*
