# Notification System Plan — Blood Setu

## Overview

This document covers the complete design for the notification system in the Blood Setu app. It includes what technologies are needed, why each one is chosen, how Firebase must be configured, how Flutter must be configured, and a full implementation plan.

---

## 1. Notification Types

| # | Type | Trigger | Recipients |
|---|------|---------|------------|
| 1 | Blood Request | New request posted | All active donors within 20 km with compatible blood group |
| 2 | Donor Coming | Donor taps "I'm Coming" | The request creator |
| 3 | Request Fulfilled / Expired | Creator marks fulfilled OR auto-expires | All donors who marked "I'm Coming" |
| 4 | Chat Message | New message sent | The recipient (only when not actively in that chat) |
| 5 | SOS Emergency | SOS button pressed on home screen | All active donors within 20 km (any blood group) |

---

## 2. Technologies Required

### 2.1 Firebase Cloud Messaging (FCM)
**Package:** `firebase_messaging: ^16.2.2` ← already in pubspec.yaml, just commented out

**Why:** FCM is the standard push notification delivery service for Android and iOS. It delivers notifications even when the app is killed or in the background. It's free, scales automatically, and integrates directly with Firebase Cloud Functions.

**What it does in this system:**
- Delivers push notifications to user devices for all 5 notification types above
- Provides each device a unique FCM token that is used to target specific users

---

### 2.2 Firebase Cloud Functions (Node.js)
**Why:** The notification logic cannot live in the Flutter app because the app may be closed. Cloud Functions are server-side triggers that run automatically when Firestore data changes. They handle:
- Querying which users are within 20 km
- Checking user preferences (notifications enabled/disabled)
- Sending FCM messages to the right tokens
- Writing notification records to Firestore for the in-app notification center

**Triggers needed:**

| Function | Trigger | Action |
|---|---|---|
| `onRequestCreated` | New doc in `blood_requests` | Query nearby donors (20 km) → filter by blood group → send FCM |
| `onDonorComing` | New doc in `blood_requests/{id}/interested/{uid}` | Send FCM to request creator |
| `onRequestStatusChanged` | `blood_requests/{id}` status field updated | Send FCM to all interested donors |
| `onMessageSent` | New doc in `conversations/{id}/messages` | Send FCM to recipient |
| `onSOSPressed` | `blood_requests` doc with type = 'sos' | Broadcast FCM to all nearby active donors |

---

### 2.3 Cloud Firestore
**Why:** Already in use in the app. Firestore stores:
1. Notification records per user (the in-app notification center)
2. User FCM tokens
3. User notification preferences (on/off toggle)

---

### 2.4 flutter_local_notifications
**Package:** `flutter_local_notifications: ^18.x.x`

**Why:** When the app is in the **foreground**, FCM does not automatically display a notification banner on Android. This package handles displaying a visible notification banner while the user is actively using the app. It also allows customizing notification appearance (icon, color, channel).

---

## 3. Firestore Data Structure

### 3.1 User FCM Token and Preferences
Stored on the existing `users/{uid}` document — add these fields:

```
users/{uid}
  fcmToken: String          // device token, updated on login and token refresh
  notificationsEnabled: bool  // mirrors the profile toggle (already exists in UI)
```

### 3.2 In-App Notification Records
Each user has a `notifications` subcollection:

```
users/{uid}/notifications/{notificationId}
  id: String
  type: 'blood_request' | 'donor_coming' | 'request_fulfilled' | 'chat' | 'sos'
  title: String
  body: String
  read: bool
  createdAt: Timestamp
  payload: {
    requestId: String?       // for blood_request, donor_coming, request_fulfilled, sos
    conversationId: String?  // for chat
    otherUid: String?        // for chat
  }
```

**Why subcollection:** Keeps notifications isolated per user, easy to query by unread count, and easy to paginate.

---

## 4. Firebase Configuration

### 4.1 Enable Cloud Messaging in Firebase Console
1. Go to Firebase Console → Project Settings → Cloud Messaging tab
2. Verify the **Server key** is present (used by Cloud Functions to send FCM)
3. For iOS: upload the **APNs Authentication Key** (.p8 file from Apple Developer account) — required for iOS push delivery

### 4.2 Firestore Indexes
Add a composite index for querying notifications:
- Collection: `notifications`
- Fields: `uid ASC`, `read ASC`, `createdAt DESC`

This index is needed by the Cloud Function that queries which users to notify (by location + blood group) and by the app when loading the notification list.

### 4.3 Firestore Security Rules
Add rules to allow users to read/write only their own notifications:

```js
match /users/{uid}/notifications/{notificationId} {
  allow read, update: if request.auth.uid == uid;
  allow write: if false; // only Cloud Functions write notifications
}
```

FCM token write rule (user can update their own token):
```js
match /users/{uid} {
  allow update: if request.auth.uid == uid
    && request.resource.data.diff(resource.data).affectedKeys()
       .hasOnly(['fcmToken', 'notificationsEnabled']);
}
```

### 4.4 Cloud Functions Setup
Initialize Cloud Functions in the Firebase project:
```
firebase init functions
```
Choose Node.js. Deploy with:
```
firebase deploy --only functions
```

The 20 km geohash query in Cloud Functions will use the same `geoflutterfire` / geohash math already used in the Flutter app's nearby donors feature. The function will:
1. Read the new blood request's `latitude`, `longitude`, `bloodGroup`
2. Compute a geohash bounding box for 20 km radius
3. Query `user_locations` collection for users within that box
4. Filter by compatible blood group and `notificationsEnabled: true`
5. Batch-send FCM to their `fcmToken` values
6. Write a notification record to each matching `users/{uid}/notifications`

---

## 5. Flutter Configuration

### 5.1 pubspec.yaml
Uncomment and add the following packages:

```yaml
firebase_messaging: ^16.2.2      # already present, just uncomment
flutter_local_notifications: ^18.0.0  # add this
```

### 5.2 Android Configuration

**File: `android/app/src/main/AndroidManifest.xml`**

Add the following inside `<application>`:
```xml
<!-- FCM default notification channel -->
<meta-data
  android:name="com.google.firebase.messaging.default_notification_channel_id"
  android:value="blood_setu_notifications" />

<!-- Default notification icon and color -->
<meta-data
  android:name="com.google.firebase.messaging.default_notification_icon"
  android:resource="@drawable/ic_notification" />
<meta-data
  android:name="com.google.firebase.messaging.default_notification_color"
  android:resource="@color/notification_color" />
```

Add the FCM service (required for background message handling):
```xml
<service
  android:name="com.google.firebase.messaging.FirebaseMessagingService"
  android:exported="false">
  <intent-filter>
    <action android:name="com.google.firebase.MESSAGING_EVENT" />
  </intent-filter>
</service>
```

Add permission for posting notifications (Android 13+):
```xml
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

**Why:** Android 13+ requires explicit `POST_NOTIFICATIONS` permission. The channel ID and default icon ensure notifications look correct when the app is in background or killed.

---

**File: `android/app/src/main/res/values/colors.xml`** (create if not exists)
```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
  <color name="notification_color">#C62828</color>
</resources>
```

Add a notification icon at `android/app/src/main/res/drawable/ic_notification.png` — should be a white-on-transparent PNG (24×24dp).

---

### 5.3 iOS Configuration

**File: `ios/Runner/Info.plist`**

Add:
```xml
<key>UIBackgroundModes</key>
<array>
  <string>fetch</string>
  <string>remote-notification</string>
</array>
```

**Why:** iOS requires declaring background modes explicitly. Without `remote-notification`, push notifications won't wake the app.

**File: `ios/Runner/Runner.entitlements`** (create if not exists)
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>aps-environment</key>
  <string>development</string>  <!-- change to 'production' for release builds -->
</dict>
</dict>
</plist>
```

**Why:** The entitlements file enables APNs (Apple Push Notification service), which FCM uses under the hood on iOS.

In Xcode: enable **Push Notifications** and **Background Modes → Remote notifications** under Signing & Capabilities.

---

## 6. Flutter Implementation Plan

### 6.1 NotificationService (new file)
**Path:** `lib/application/core/services/notification_service.dart`

Responsibilities:
- Initialize `firebase_messaging` and `flutter_local_notifications` on app start
- Request notification permissions from the user (Android 13+ / iOS)
- Get the FCM token and save it to Firestore `users/{uid}/fcmToken`
- Listen for token refresh and update Firestore
- Handle foreground messages → show local notification banner
- Handle notification tap (app opened from notification) → navigate to the correct screen based on `payload.type`

Called once from `main.dart` after Firebase is initialized and the user is signed in.

---

### 6.2 NotificationRepository (new file)
**Path:** `lib/data/repositories/notification_repository.dart`

Methods:
```dart
// Stream of all notifications for current user, newest first
Stream<List<AppNotification>> watchNotifications(String uid);

// Count of unread notifications
Stream<int> watchUnreadCount(String uid);

// Mark a single notification as read
Future<void> markRead(String uid, String notificationId);

// Mark all as read
Future<void> markAllRead(String uid);

// Save FCM token to Firestore
Future<void> saveFcmToken(String uid, String token);

// Save notification preference
Future<void> setNotificationsEnabled(String uid, bool enabled);
```

---

### 6.3 NotificationBloc (new)
**Path:** `lib/application/pages/features/notifications/bloc/`

States: `loading`, `loaded(List<AppNotification> items, int unreadCount)`, `error`

Events: `started(uid)`, `notificationTapped(AppNotification)`, `markAllReadPressed`

This BLoC is provided at the app root level (above `BottomNav`) so the unread count badge on the home bell icon stays live across tabs.

---

### 6.4 AppNotification Model (new)
**Path:** `lib/domain/models/app_notification.dart`

```dart
@freezed
class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required String type,   // 'blood_request' | 'donor_coming' | 'chat' | 'sos' | 'request_fulfilled'
    required String title,
    required String body,
    required bool read,
    required DateTime createdAt,
    String? requestId,
    String? conversationId,
    String? otherUid,
  }) = _AppNotification;
}
```

---

### 6.5 Notification Panel Screen (new)
**Path:** `lib/application/pages/features/notifications/view/notifications_screen.dart`

- Full screen list of notifications, grouped by Today / Yesterday / Earlier
- Unread items have a highlighted background
- Tapping a notification: marks it read + navigates to the relevant screen
  - `blood_request` → push to blood request detail
  - `donor_coming` → push to my requests screen
  - `chat` → navigate to that conversation
  - `sos` → push to blood requests screen (filtered to SOS type)
  - `request_fulfilled` → push to my interests screen

---

### 6.6 Home Screen Bell Icon — Wire Up
**File:** `lib/application/pages/features/home/view/home_screen.dart`
**Location:** `_TopBar` widget (line ~232)

Currently:
```dart
IconButton(
  onPressed: () {},   // does nothing
  icon: const Icon(Icons.notifications_outlined),
)
// badge shows hardcoded '3'
```

After wiring:
- Badge reads `unreadCount` from `NotificationBloc`
- `onPressed` pushes to `NotificationsScreen`
- Badge is hidden when `unreadCount == 0`

---

### 6.7 Profile Toggle — Wire to Firestore
**File:** `lib/application/pages/features/profile/bloc/profile_bloc.dart`
**Location:** `notificationsToggled` handler (line ~51)

Currently:
```dart
notificationsToggled: () async =>
    emit(state.copyWith(notifications: !state.notifications)),
```

After wiring:
- Also calls `NotificationRepository.setNotificationsEnabled(uid, !current)`
- Cloud Functions check this field before sending FCM to that user

---

## 7. Notification Delivery Flow (end-to-end)

### Blood Request (20 km)
```
User posts request
  → Firestore: new doc in blood_requests
  → Cloud Function: onRequestCreated fires
  → Reads lat/lng/bloodGroup from the new doc
  → Queries user_locations with geohash bounding box (20 km)
  → Filters: isActive = true, compatible blood group, notificationsEnabled = true
  → For each matching user:
      → Sends FCM to their fcmToken
      → Writes doc to users/{uid}/notifications
  → Device receives FCM:
      → App killed/background: system shows push notification
      → App foreground: flutter_local_notifications shows banner
  → User taps notification → opens app → navigates to blood request
```

### Chat Message
```
User A sends message to User B
  → Firestore: new doc in conversations/{id}/messages
  → Cloud Function: onMessageSent fires
  → Checks if User B is currently in that conversation (online field or last_seen)
  → If not active in chat: sends FCM + writes notification to users/{B}/notifications
  → User B receives push, taps → opens that conversation
```

### SOS
```
User presses SOS button
  → HomeBloc: sosPressed event → creates a blood request with type = 'sos'
  → Cloud Function: onRequestCreated (or separate onSOS trigger)
  → Queries ALL active donors within 20 km (no blood group filter for SOS)
  → Sends high-priority FCM with urgency flag to all their tokens
  → Writes notification to each users/{uid}/notifications with type = 'sos'
```

---

## 8. Implementation Order

1. **Uncomment** `firebase_messaging` in `pubspec.yaml`, add `flutter_local_notifications`
2. **Android & iOS config** — manifest, Info.plist, entitlements, icons
3. **AppNotification model** — freezed class
4. **NotificationRepository** — Firestore reads/writes
5. **NotificationService** — FCM init, token save, foreground handler, tap navigation
6. **NotificationBloc** — stream unread count and notification list
7. **Wire Profile toggle** — save preference to Firestore
8. **Wire Home bell icon** — real unread count badge + navigate to notifications screen
9. **Notifications screen** — list UI with read/unread states
10. **Cloud Functions** — deploy all 5 trigger functions

---

## 9. What Already Exists (No Changes Needed)

| Item | Location | Status |
|------|----------|--------|
| Firebase setup | `lib/di/di.dart`, `google-services.json` | Done |
| Geohash 20 km query | `user_locations` collection + nearby donors feature | Done |
| Profile notification toggle UI | `profile_bloc.dart` `notificationsToggled` event | UI done, needs Firestore wire |
| Home bell icon UI | `home_screen.dart` `_TopBar` | UI done, needs real data |
| Blood group compatibility | `blood_compat_util.dart` | Done |
| `firebase_messaging` package | `pubspec.yaml` line 51 | Present, just commented out |
