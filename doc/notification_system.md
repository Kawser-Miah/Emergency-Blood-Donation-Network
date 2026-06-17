# Foreground Chat Notification System

Displays Android heads-up notifications when a new chat message arrives while the app is in the foreground. No Firebase Functions or FCM required — detection and display are handled entirely on-device.

---

## How It Works

```
Firestore stream
      │
      ▼
ConversationListBloc          ← listens to all conversations
      │
      │  unread count delta detected?
      │  sender ≠ current user?
      │  conversation NOT active?
      ▼
NotificationService.showChatNotification()
      │
      ▼
flutter_local_notifications   → heads-up banner (Android)
      │
      │  user taps banner
      ▼
_onNotificationTap()
      │
      ▼
AppRouter.push → ChatScreen   ← contact fields pre-populated from payload
```

### Step-by-step

1. **App starts** — `configureDependencies()` in `main.dart` initialises `NotificationService` via `@PostConstruct(preResolve: true)`. The Android notification channel `chat_messages` (high importance = heads-up) is created here.

2. **User opens any screen** — `ConversationListBloc` subscribes to `ChatUseCase.watchConversations()`, which streams Firestore updates for every conversation the user belongs to.

3. **Message arrives** — Firestore pushes a new snapshot. `_emitLoaded()` compares each conversation's current `unreadCounts[currentUid]` against the previous snapshot (`_prevUnreadCounts`).

4. **Notification decision** — A notification fires when **all three** are true:
   - `newCount > prevCount` — at least one new unread message
   - `lastMessageSenderId != currentUid` — the sender is someone else
   - `conversationId != _activeConversationId` — the user is not already viewing that chat

5. **Notification shown** — `showChatNotification()` calls `_plugin.show()` with:
   - Title = sender name (from full profile if cached, else from denormalised `participants` map)
   - Body = message text, truncated to 60 characters + `…`
   - Timestamp = `when: messageTime.millisecondsSinceEpoch` (top-right corner on Android)
   - Payload = JSON with all fields needed to open the correct chat screen

6. **User taps notification** — `_onNotificationTap()` decodes the payload and calls `AppRouter.router.push(PAGES.chat.screenPath, extra: ChatScreenArgs(...))`. The `ChatContact` inside `ChatScreenArgs` is built entirely from the payload, so the chat header (name, initials, avatar colour, blood group) is never blank.

7. **Suppression while chatting** — when `ChatBloc._startWatching()` runs it calls `NotificationService.setActiveConversation(conversationId)`. When the user leaves, `ChatBloc.close()` resets it to `null`. This is the gate checked in step 4.

---

## Suppression Rules

| Where the user is | Message arrives in | Notification shown? |
|---|---|---|
| Home / Donors / Profile tab | Any conversation | Yes |
| Chat List screen | Any conversation | Yes |
| ChatScreen (conv **X**) | Conv **X** | **No** — active conversation match |
| ChatScreen (conv **X**) | Conv **Y** | Yes |

---

## Source File Reference

| File | Role |
|---|---|
| [`lib/application/core/services/notification_service/notification_service.dart`](../lib/application/core/services/notification_service/notification_service.dart) | Core service — channel setup, show, suppress, tap handler |
| [`lib/application/pages/features/chat_list/bloc/conversation_list_bloc.dart`](../lib/application/pages/features/chat_list/bloc/conversation_list_bloc.dart) | Detects unread count delta, calls `showChatNotification()` |
| [`lib/application/pages/features/chat/bloc/chat_bloc.dart`](../lib/application/pages/features/chat/bloc/chat_bloc.dart) | Registers / clears active conversation ID |
| [`lib/main.dart`](../lib/main.dart) | Calls `configureDependencies()` which pre-resolves `NotificationService.init()` |
| [`lib/di/di.config.dart`](../lib/di/di.config.dart) | Auto-generated DI — registers `NotificationService` as `lazySingletonAsync` with `preResolve: true` |
| [`android/app/src/main/AndroidManifest.xml`](../android/app/src/main/AndroidManifest.xml) | Declares `POST_NOTIFICATIONS` and `RECEIVE_BOOT_COMPLETED` permissions |
| [`pubspec.yaml`](../pubspec.yaml) | `flutter_local_notifications: ^18.0.0` (installed v18.0.1) |

---

## Key Classes & Methods

### `NotificationService` — `@lazySingleton`
> `lib/application/core/services/notification_service/notification_service.dart`

| Member | Description |
|---|---|
| `init()` | Creates the `chat_messages` Android channel (Importance.high = heads-up). Called automatically by DI via `@PostConstruct(preResolve: true)`. |
| `setActiveConversation(String? id)` | Called by `ChatBloc` on open/close. Sets the suppression gate. |
| `showChatNotification({...})` | Shows a notification unless the target conversation is currently active. Truncates body at 60 chars. Stores contact fields in JSON payload. |
| `_onNotificationTap(NotificationResponse)` | Decodes payload, builds `ChatScreenArgs` with a fully-populated `ChatContact`, and pushes to `/chat`. |

### `ConversationListBloc`
> `lib/application/pages/features/chat_list/bloc/conversation_list_bloc.dart`

| Member | Description |
|---|---|
| `_prevUnreadCounts` | `Map<String, int>` snapshot from the last Firestore update. Reset to `{}` on `watchStarted` to prevent stale fires after re-login. |
| `_emitLoaded()` | After emitting state, iterates all conversations and calls `showChatNotification()` for any with a rising unread count from another sender. |

### `ChatBloc`
> `lib/application/pages/features/chat/bloc/chat_bloc.dart`

| Member | Description |
|---|---|
| `_startWatching()` | Calls `setActiveConversation(_conversationId)` so notifications for this chat are suppressed. |
| `close()` | Calls `setActiveConversation(null)` to re-enable notifications when the user navigates away. |

---

## Android Channel Configuration

| Property | Value |
|---|---|
| Channel ID | `chat_messages` |
| Channel name | Chat Messages |
| Importance | `Importance.high` (triggers heads-up banner on Android 8+) |
| Priority | `Priority.high` |
| Timestamp | `showWhen: true`, value = `messageTime.millisecondsSinceEpoch` |

---

## Notification Payload Schema

```json
{
  "conversationId": "string",
  "currentUid":     "string",
  "otherUid":       "string",
  "senderName":     "string",
  "bloodGroup":     "string",
  "initials":       "string",
  "avatarColor":    "string"
}
```

All fields are stored at the time the notification is shown (sourced from `conv.participants[senderUid]` inside `ConversationListBloc`). On tap, `_onNotificationTap` reads them back to build the `ChatContact` — no Firestore call on tap.

---

## DI Wiring

```dart
// di.config.dart (auto-generated — do not edit)
await gh.lazySingletonAsync<NotificationService>(() {
  final i = NotificationService();
  return i.init().then((_) => i);   // init() runs before any BLoC is resolved
}, preResolve: true);

gh.factory<ChatBloc>(
  () => ChatBloc(gh<ChatUseCase>(), gh<NotificationService>()),
);

gh.factory<ConversationListBloc>(
  () => ConversationListBloc(gh<ChatUseCase>(), gh<NotificationService>()),
);
```

`preResolve: true` ensures `init()` completes (channel created, plugin initialised) before `runApp()` is called.
