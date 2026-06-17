# Notification System — Task Checklist

## Feature: Foreground In-App Chat Notifications

Uses `flutter_local_notifications` to show system heads-up notifications when a new chat message arrives, without Firebase Functions.

**Notification layout:** Title = sender name | Body = truncated message (max 60 chars + `…`) | Timestamp in top-right corner (Android `when` field).

---

### Task 1 — Add Package ✅

**File:** `pubspec.yaml`
- [x] Add under `dependencies:`:
  ```yaml
  flutter_local_notifications: ^18.0.0
  ```
- [x] Run `flutter pub get` — installed v18.0.1

---

### Task 2 — Android Configuration ✅

**File:** `android/app/src/main/AndroidManifest.xml`
- [x] Add inside `<manifest>` (before `<application>`):
  ```xml
  <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
  <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
  ```

---

### Task 3 — Create NotificationService ✅

> **Implementation notes:**
> - Android-only: `DarwinInitializationSettings` and `DarwinNotificationDetails` removed (iOS not needed)
> - `@PostConstruct(preResolve: true)` added to `init()` — DI calls it automatically (see Task 4)

**File:** `lib/application/core/services/notification_service/notification_service.dart`

#### 3a — `ChatNotification` value class (top of file)
Fields:
- `String conversationId`
- `String senderName`
- `String bloodGroup`
- `String messageText`
- `String currentUid`
- `String otherUid`
- `DateTime messageTime`

#### 3b — `NotificationService` class (`@lazySingleton`)
Fields:
- `final _plugin = FlutterLocalNotificationsPlugin()`
- `String? _activeConversationId`
- `int _notifId = 0`

#### 3c — `init()` method
```dart
Future<void> init() async {
  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosSettings = DarwinInitializationSettings();
  await _plugin.initialize(
    const InitializationSettings(android: androidSettings, iOS: iosSettings),
    onDidReceiveNotificationResponse: _onNotificationTap,
  );
  // Create high-importance channel (required for heads-up on Android 8+)
  const channel = AndroidNotificationChannel(
    'chat_messages',
    'Chat Messages',
    importance: Importance.high,
  );
  await _plugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}
```

#### 3d — `setActiveConversation(String? id)` method
```dart
void setActiveConversation(String? id) => _activeConversationId = id;
```

#### 3e — `showChatNotification(...)` method
> **Updated:** added `bloodGroup`, `initials`, `avatarColor` params; stored in payload so `_onNotificationTap` can build a complete `ChatContact`. `ChatScreen` never fetches contact details from Firestore, so the payload is the only source of truth on tap.

```dart
Future<void> showChatNotification({
  required String conversationId,
  required String senderName,
  required String messageText,
  required String currentUid,
  required String otherUid,
  required DateTime messageTime,
  required String bloodGroup,
  required String initials,
  required String avatarColor,
}) async {
  if (conversationId == _activeConversationId) return; // suppress active chat
  const maxLen = 60;
  final body = messageText.length > maxLen
      ? '${messageText.substring(0, maxLen)}…'
      : messageText;
  await _plugin.show(
    _notifId++,
    senderName,   // title = sender name
    body,         // body = truncated message
    NotificationDetails(
      android: AndroidNotificationDetails(
        'chat_messages',
        'Chat Messages',
        importance: Importance.high,
        priority: Priority.high,
        when: messageTime.millisecondsSinceEpoch, // timestamp top-right
        showWhen: true,
      ),
    ),
    payload: jsonEncode({
      'conversationId': conversationId,
      'currentUid': currentUid,
      'otherUid': otherUid,
      'senderName': senderName,
      'bloodGroup': bloodGroup,
      'initials': initials,
      'avatarColor': avatarColor,
    }),
  );
}
```

#### 3f — `_onNotificationTap` callback (private method)
> **Updated:** reads contact fields from payload to populate `ChatContact` properly — no blank header on tap.

```dart
void _onNotificationTap(NotificationResponse response) {
  final data = jsonDecode(response.payload ?? '{}') as Map<String, dynamic>;
  final conversationId = data['conversationId'] as String?;
  final currentUid   = data['currentUid']   as String?;
  final otherUid     = data['otherUid']     as String?;
  if (conversationId == null) return;
  AppRouter.router.push(
    PAGES.chat.screenPath,
    extra: ChatScreenArgs(
      conversationId: conversationId,
      currentUid: currentUid ?? '',
      otherUid: otherUid ?? '',
      contact: ChatContact(
        id: otherUid ?? '',
        name: data['senderName'] as String? ?? '',
        bloodGroup: data['bloodGroup'] as String? ?? '',
        initials: data['initials'] as String? ?? '',
        avatarColor: data['avatarColor'] as String? ?? '',
        online: false,
      ),
    ),
  );
}
```

**Imports needed:** `dart:convert`, `flutter_local_notifications`, `injectable`, `package:blood_setu/application/core/services/routing/app_router.dart`, `package:blood_setu/application/core/services/routing/routing_utils.dart`, `package:blood_setu/domain/models/chat_contact.dart`, `package:blood_setu/domain/models/chat_screen_args.dart`

---

### Task 4 — Initialize Service at Startup ✅

> **Implementation note:** Using `@PostConstruct(preResolve: true)` on `init()` instead of calling it manually in `main.dart`. DI auto-calls it during `configureDependencies()`. `main.dart` requires no changes.

**File:** `lib/main.dart`
- [x] No manual call needed — handled by `@PostConstruct(preResolve: true)` in `NotificationService`

---

### Task 5 — Detect New Messages in ConversationListBloc

**File:** `lib/application/pages/features/chat_list/bloc/conversation_list_bloc.dart`

- [ ] Inject `NotificationService _notificationService` via constructor (alongside existing `ChatUseCase _useCase`)
- [ ] Add field: `Map<String, int> _prevUnreadCounts = {}`
- [ ] In `_startWatching(uid)`: reset `_prevUnreadCounts = {}` (prevents stale fires on re-login)
- [ ] In `_emitLoaded()`, after the existing `emit(...)` call, add detection loop:

```dart
// Detect new inbound messages
if (_prevUnreadCounts.isNotEmpty) {
  for (final conv in all) {
    final newCount  = conv.unreadCounts[_currentUid] ?? 0;
    final prevCount = _prevUnreadCounts[conv.id]     ?? 0;
    if (newCount > prevCount &&
        conv.lastMessageSenderId != _currentUid &&
        conv.lastMessage.isNotEmpty) {
      final senderUid = conv.lastMessageSenderId;
      // Prefer freshly-fetched profile, fall back to denormalized participant data
      final profile     = profiles[senderUid];
      final participant = conv.participants[senderUid];
      final name        = profile?.fullName
          ?? participant?.name
          ?? 'New message';
      _notificationService.showChatNotification(
        conversationId: conv.id,
        senderName:     name,
        messageText:    conv.lastMessage,      // non-nullable String
        currentUid:     _currentUid,
        otherUid:       senderUid,
        messageTime:    conv.lastMessageTime,  // non-nullable DateTime
        bloodGroup:     participant?.bloodGroup ?? '',
        initials:       participant?.initials   ?? '',
        avatarColor:    participant?.avatarColor ?? '',
      );
    }
  }
}
// Update snapshot for next comparison
_prevUnreadCounts = {
  for (final c in all) c.id: c.unreadCounts[_currentUid] ?? 0
};
```

> Note: `profiles` is already resolved inside `_emitLoaded()` via `existing?.profiles ?? {}` — reuse it directly.

---

### Task 6 — Track Active Conversation in ChatBloc

**File:** `lib/application/pages/features/chat/bloc/chat_bloc.dart`

- [ ] Inject `NotificationService _notificationService` via constructor (alongside existing `ChatUseCase _useCase`)
- [ ] In `_startWatching()`, after setting `_conversationId`:
  ```dart
  _notificationService.setActiveConversation(_conversationId);
  ```
- [ ] In `close()`, before `return super.close()`:
  ```dart
  _notificationService.setActiveConversation(null);
  ```

---

### Task 7 — Regenerate DI ✅

- [x] Run: `dart run build_runner build --delete-conflicting-outputs`
- [x] `lib/di/di.config.dart` registers `NotificationService` as `lazySingletonAsync` with auto-init via `i.init().then((_) => i)`
- [ ] Confirm injection into `ConversationListBloc` and `ChatBloc` after Tasks 5 & 6 are done — re-run build_runner then

---

### Task 8 — Verify & Test

- [ ] `flutter analyze` → zero warnings/errors
- [ ] On Android: go to Home tab → from another account send a message → heads-up notification appears with sender name, short message body, and timestamp top-right
- [ ] Open that conversation → receive another message → **no notification**
- [ ] Open conversation X, someone sends in conversation Y → notification shows for Y
- [ ] Tap notification → app navigates to correct chat screen
- [ ] Send message longer than 60 chars → body truncated with `…`

---

### Suppression Rules

| User location | Message arrives in | Show notification? |
|---|---|---|
| Home / Donors / Profile tab | Any conversation | Yes |
| Chat List tab | Any conversation | Yes |
| ChatScreen (conv X) | Conv X | **No** (`activeConversationId` match) |
| ChatScreen (conv X) | Conv Y | Yes |

---

### Key Model Reference

**`Conversation`** fields used (from `lib/domain/models/conversation.dart`):
- `id` — String
- `participantIds` — List\<String\>
- `participants` — Map\<String, ConversationParticipant\> (has `.name`, `.bloodGroup`, `.initials`, `.avatarColor`)
- `lastMessage` — String (non-nullable)
- `lastMessageTime` — DateTime (non-nullable)
- `lastMessageSenderId` — String
- `unreadCounts` — Map\<String, int\> keyed by uid

**`UserProfileModel`** field used: `fullName` (String?)
