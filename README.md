# Blood Setu

**Blood Setu** (Bengali: "Blood Bridge") is a Flutter-based blood donation matching platform that connects blood donors with recipients in real time. The app helps users find compatible nearby donors, post emergency blood requests, track their donation history, and communicate directly with donors via in-app chat.

---

## Table of Contents

1. [Overview](#overview)
2. [Features](#features)
3. [Tech Stack](#tech-stack)
4. [Architecture](#architecture)
5. [Project Structure](#project-structure)
6. [Screens and Navigation](#screens-and-navigation)
7. [Core Modules](#core-modules)
8. [Data Models](#data-models)
9. [Firestore Collections](#firestore-collections)
10. [State Management](#state-management)
11. [Dependency Injection](#dependency-injection)
12. [Routing](#routing)
13. [Firebase Integration](#firebase-integration)
14. [UI Design System](#ui-design-system)
15. [Utilities](#utilities)
16. [Getting Started](#getting-started)
17. [Platform Support](#platform-support)
18. [Contributing](#contributing)

---

## Overview

Blood Setu is a community-driven blood donation app built with Flutter. It enables:

- **Donors** to register their blood group and location, set their availability status, and respond to urgent nearby requests.
- **Recipients** to post blood requests with urgency levels, hospital details, and contact information.
- **Real-time matching** of donors and recipients by blood compatibility and geolocation using geohash.
- **In-app messaging** so donors and requesters can coordinate directly without sharing personal contact info.

The app currently targets Android (fully configured with Firebase). The project scaffold supports iOS, Web, Windows, macOS, and Linux as well.

---

## Features

### Authentication

- Google Sign-In via Firebase Authentication
- Persistent session: `AuthController` (a `ChangeNotifier`) wraps `FirebaseAuth.authStateChanges()` and acts as GoRouter's `refreshListenable`, triggering redirect evaluation on every auth state change
- Auto-redirect logic:
  - Not initialized → Splash screen
  - No user → Sign In screen
  - User exists, profile incomplete → Registration screen
  - User exists, profile complete, on auth/splash screens → Home

### User Registration and Profile

- **Two-step registration form:**
  - **Step 1 — Personal Info:** Full name, gender, phone number (11-digit, starting with `01`), blood group (chip selector with 8 groups), age (14–65), last donation date (date picker with custom red theme)
  - **Step 2 — Location and Contact:** District (searchable bottom sheet), thana/upazila (searchable bottom sheet filtered by selected district), Facebook Messenger ID, donation eligibility confirmation checkbox
- `RegistrationSelectionSheet` — a `DraggableScrollableSheet` with live search for selecting from all 64 Bangladesh districts and their respective thanas
- **Edit Profile** reuses the same registration form with `initialProfile` pre-filled
- Dual write on save: Firestore `profile/{uid}` (full data) and `user_locations/{uid}` (searchable donor index with computed geohash)
- **Donor tiers** based on total donations: Bronze (≥1), Silver (≥5), Gold (≥10), Platinum (≥20)

### Home Screen

- **Welcome card** — greets user by name, shows total donation count, days until next eligible donation, and active/inactive status toggle
- **Daily Inspiration quote** — 10 rotating blood donation quotes; selection is based on `DateTime.now().dayOfYear % 10`, changing once per day without any server call
- **Nearby Donors section** — horizontal scroll list of up to 5 compatible donors sorted by distance using geohash; "See All" navigates to the full Donors screen
- **Active Blood Requests section** — vertical list of up to 5 recent active requests with blood compatibility highlighting; "I'm Coming" button and direct message button
- **Floating Action Button** — quick-launch Create Blood Request screen

### Blood Requests

- Browse all active blood requests with real-time Firestore cursor-based pagination (triggers at 300px from bottom)
- **Search** by patient name, hospital name, or blood group
- **Quick filter chips** — all 9 blood groups shown horizontally in the header
- **Full filter sheet** — filter by blood group and urgency (CRITICAL / URGENT / NORMAL)
- **Blood compatibility check** — `isBloodGroupCompatible()` utility highlights requests the current user can help with
- **"I'm Coming"** — one-tap donor interest registration with optimistic UI update and snackbar feedback
- **Message button** — launches in-app chat with the requester

### Create Blood Request

- Multi-card form:
  - Patient details (name, blood group chip selector, units stepper)
  - Urgency selection (CRITICAL / URGENT / NORMAL with color-coded chips)
  - Location (GPS auto-detect or manual map picker via OpenStreetMap)
  - Date picker (need-by date with custom red theme)
  - Additional info (hospital name, contact number, notes)
- Full validation on submission; geohash is computed from coordinates before saving to Firestore

### My Requests

- List of all blood requests posted by the current user
- Auto-expiry: `MyRequestsBloc` batch-updates past-due active requests to `expired` status on load
- Tap any card to open a **detail sheet** showing:
  - Full request info (blood group, urgency badge, patient, need-by date, hospital, address, units, contact, notes, posted timestamp)
  - Action buttons: Edit Request (active requests only), Mark Fulfilled, Delete Request (with confirmation dialog)
  - "Who's Coming" section — list of donors who expressed interest, each with a Chat button
- **Edit sheet** — full edit form for any request field with save/cancel

### My Interests

- List of all blood requests the current user registered interest in ("I'm Coming")
- **Mark Blood Given** — records a `DonationHistoryEntry` and updates total donations + donor tier atomically in Firestore (guarded by `isBloodGroupCompatible()`)
- **Withdraw Interest** — removes the donor from `interested_donors` subcollection and from `profile/{uid}/my_interests`

### Nearby Donors

- Full geohash-based donor search with **radius-ring pagination**:
  - Starts at 10 km; expands 10 → 20 → 40 → 80 km (doubling), then +50 km steps up to 1000 km
  - Per-blood-group last-successful radius cached in SharedPreferences so subsequent searches start near where the previous one succeeded
- Filter by blood group and max distance
- Search by name
- Tap a donor card to open a detail sheet with contact info, donation stats, and a Chat button

### Chat

- Real-time 1-to-1 messaging powered by Cloud Firestore (messages) and Firebase Realtime Database (presence and typing)
- On open: creates or fetches the conversation, starts three concurrent stream subscriptions (messages, presence, typing), sets the user's RTDB status to online
- On close: sets RTDB status to offline/lastSeen
- **Features:**
  - Message bubbles with sender-aligned layout and timestamps
  - Date separators between messages from different days
  - Animated typing indicator (three dots) via RTDB with 5-second idle timeout
  - Quick reply suggestion chips
  - Emoji picker (`emoji_picker_flutter`)
  - Attachment sheet (camera, gallery, file, location — UI present, upload integration planned)
  - Last seen timestamp in the app bar
  - Automatic mark-as-read on open and on each incoming batch
  - Chat source context (why the conversation was started: `bloodRequest`, `donorCard`, `interestResponse`, `direct`)

### Chat List

- All conversations for the current user, streamed in real time from Firestore
- Sorted by last message time
- Lazy batch-fetch of participant profiles (merged into state as they arrive)
- Search conversations by participant name or blood group
- Unread count badge, last message preview, and relative timestamp

### Profile

- **Cover photo section** — rich gradient (deep red `#7B0000` → `#B71C1C` → `#E53935`), wave-cut bottom edge via `ClipPath`/`CustomClipper`, blood group badge (frosted glass pill, top-left), active/inactive status badge with glowing dot (top-right), large avatar with radial gradient glow ring and white border
- **Quick Action cards** — three prominent colored cards directly under the cover:
  - My Requests (red / `AppColors.primarySurface`)
  - My Interests (purple / `Color(0xFFF3E5F5)`)
  - Edit Profile (blue / `AppColors.infoSurface`)
- **Stats card** — total donations, next eligible date, last donated
- **Badges section** — donation milestone badges; tap "See All" to view all earned badges
- **Donation history** — chronological list; tap "See All" to view full history with PDF export
- **Personal info section** — expandable (age, gender, district, thana, phone, FB Messenger)
- **Settings section** — Privacy Policy, Privacy Settings (placeholder), App Language (placeholder), Logout (with confirmation)
- **Record Donation FAB** — bottom sheet to log a new manual donation entry

### Privacy Policy

- Full in-app privacy policy screen with a gradient red header card
- 9 expandable `ExpansionTile` sections: Information Collected, How We Use It, Location Data, Data Sharing, Data Security, Your Rights, Children's Privacy, Policy Changes, Contact Us

### PDF Export

- Donation certificate PDF generated via the `pdf` package and shared via the `printing` package
- Contains: donor profile info, earned badges, and a full donation history table

---

## Tech Stack

| Category | Technology | Version |
|---|---|---|
| Framework | Flutter (Dart) | SDK ^3.11.5 |
| State Management | flutter_bloc | ^9.1.1 |
| Immutable Models | freezed + freezed_annotation | ^2.4.2 / ^2.4.1 |
| JSON Codegen | json_serializable + json_annotation | ^6.7.1 / ^4.8.1 |
| Dependency Injection | get_it + injectable | ^9.2.1 / ^2.5.2 |
| Navigation | go_router | ^17.2.3 |
| Firebase Core | firebase_core | ^4.9.0 |
| Firebase Auth | firebase_auth | ^6.5.1 |
| Firestore | cloud_firestore | ^6.4.1 |
| Realtime Database | firebase_database | ^12.4.1 |
| Google Sign-In | google_sign_in | ^7.2.0 |
| Geolocation | geolocator | ^14.0.0 |
| Reverse Geocoding | geocoding | ^3.0.0 |
| Map Widget | flutter_map | ^8.3.0 |
| Map Types | latlong2 | ^0.9.1 |
| Emoji Picker | emoji_picker_flutter | ^4.4.0 |
| PDF Generation | pdf + printing | ^3.11.1 / ^5.13.2 |
| Local Storage | shared_preferences | ^2.5.5 |
| URL Launcher | url_launcher | ^6.3.1 |
| Functional Types | dartz | ^0.10.1 |
| Equality | equatable | ^2.0.7 |
| Date Formatting | intl | ^0.20.2 |
| Code Generation | build_runner | ^2.4.13 |
| DI Generator | injectable_generator | ^2.6.2 |
| Fonts | Poppins (via ThemeData.fontFamily) | — |

**Commented out (planned, not yet active):** `firebase_messaging`, `firebase_storage`, `cloud_functions`, `google_maps_flutter`, `geoflutterfire_plus`

---

## Architecture

Blood Setu follows **Clean Architecture** principles with **BLoC** as the presentation-layer state management pattern.

```
┌─────────────────────────────────────────┐
│  Presentation  │  BLoC (Events→States)  │
│                │  Widgets / Screens      │
├─────────────────────────────────────────┤
│  Domain        │  Use Cases             │
│                │  Domain Models         │
│                │  Repository Interfaces │
├─────────────────────────────────────────┤
│  Data          │  Repository Impls      │
│                │  Firebase / GPS / SP   │
└─────────────────────────────────────────┘
```

### Layer Responsibilities

**Presentation (`lib/application/`)**
- Each feature folder has `bloc/`, `view/`, and `widgets/` sub-folders
- `view/` — one screen file, typically under 150 lines (BlocProvider + BlocConsumer/Builder + scaffold)
- `widgets/` — extracted stateless/stateful widget classes (sibling to `bloc/` and `view/`)
- `core/` — shared widgets, theme, auth controller, routing, constants, services

**Domain (`lib/domain/`)**
- Pure Dart. No framework dependencies except `cloud_firestore` Timestamps for serialization
- `models/` — Freezed immutable data classes with `fromFirestore`/`toMap`/`copyWith`
- `usecase/` — thin single-responsibility orchestrators; return `Either<Failure, T>` from `dartz`
- `repositories/` — abstract interface contracts
- `failures/` — typed failure hierarchy (`GeneralFailure`, `UserNotFoundFailure`, etc.)

**Data (`lib/data/`)**
- `repositories/` — concrete Firebase/GPS implementations, registered with `@Injectable(as: AbstractRepo)` so DI swaps them transparently
- `mock_data.dart` — static test fixtures used during development

**DI (`lib/di/`)**
- `get_it` + `injectable`; `di.config.dart` is auto-generated by `build_runner`
- `register_module.dart` manually provides `FirebaseAuth`, `FirebaseFirestore`, `FirebaseDatabase`, `GoogleSignIn`, and an `@preResolve Future<SharedPreferences>`

---

## Project Structure

```
lib/
├── main.dart
├── firebase_options.dart                  # FlutterFire-generated config
├── generated/
│   └── assets.dart
├── application/
│   ├── core/
│   │   ├── auth/
│   │   │   └── auth_controller.dart       # ChangeNotifier wrapping Firebase auth state
│   │   ├── constants/
│   │   │   └── bangladesh_locations.dart  # All 64 districts + thanas (in-memory Dart map)
│   │   ├── services/
│   │   │   ├── routing/
│   │   │   │   ├── app_router.dart        # GoRouter config + redirect logic
│   │   │   │   ├── routing_utils.dart     # PAGES enum with paths and names
│   │   │   │   └── chat_navigation.dart   # navigateToChat() helper
│   │   │   └── sp_service/
│   │   │       └── sp_service.dart        # Typed SharedPreferences wrapper
│   │   ├── theme/
│   │   │   └── colors.dart               # AppColors constants + fontFamily
│   │   └── widgets/
│   │       ├── avatar.dart               # Circular avatar with initials fallback
│   │       ├── blood_request_card.dart   # Shared card + bloodRequestUrgencyConfig
│   │       ├── bottom_nav.dart           # Custom bottom nav bar (4 tabs)
│   │       ├── registration_header_widget.dart
│   │       ├── registration_progress_widget.dart
│   │       ├── sparkle_loading_overlay.dart  # Animated sign-in loading overlay
│   │       └── typing_dots.dart          # Animated 3-dot typing indicator
│   └── pages/
│       ├── app/
│       │   └── app.dart                  # MaterialApp.router entry point
│       └── features/
│           ├── blood_requests/
│           │   ├── bloc/
│           │   ├── view/blood_requests_screen.dart
│           │   └── widgets/
│           │       ├── blood_requests_body.dart
│           │       ├── blood_requests_empty.dart
│           │       ├── blood_requests_filters_sheet.dart
│           │       └── blood_requests_header.dart
│           ├── bottom_nav/
│           │   └── view/bottom_nav_page.dart
│           ├── chat/
│           │   ├── bloc/
│           │   ├── view/chat_screen.dart
│           │   └── widgets/
│           │       ├── chat_app_bar.dart
│           │       ├── chat_attachment_sheet.dart
│           │       ├── chat_bubble.dart
│           │       ├── chat_date_separator.dart
│           │       ├── chat_helpers.dart
│           │       ├── chat_input_bar.dart
│           │       ├── chat_quick_replies.dart
│           │       └── chat_typing_row.dart
│           ├── chat_list/
│           │   ├── bloc/
│           │   ├── view/chat_list_screen.dart
│           │   └── widgets/
│           │       ├── chat_list_empty.dart
│           │       ├── chat_list_header.dart
│           │       └── chat_list_row.dart
│           ├── create_request/
│           │   ├── bloc/
│           │   ├── view/create_request_screen.dart
│           │   └── widgets/
│           │       ├── create_request_card.dart
│           │       ├── create_request_card_additional.dart
│           │       ├── create_request_card_location.dart
│           │       ├── create_request_card_patient.dart
│           │       ├── create_request_card_urgency.dart
│           │       ├── create_request_confirmations.dart
│           │       ├── create_request_date_picker.dart
│           │       ├── create_request_header.dart
│           │       ├── create_request_input_field.dart
│           │       └── create_request_options.dart
│           ├── donors/
│           │   ├── bloc/
│           │   ├── view/donors_screen.dart
│           │   └── widgets/
│           │       ├── donor_card.dart
│           │       ├── donor_details_sheet.dart
│           │       └── donor_filters_sheet.dart
│           ├── home/
│           │   ├── bloc/
│           │   ├── view/home_screen.dart
│           │   └── widgets/
│           │       ├── home_active_requests.dart
│           │       ├── home_nearby_donors.dart
│           │       ├── home_quote_card.dart
│           │       ├── home_top_bar.dart
│           │       └── home_welcome_card.dart
│           ├── map_picker/
│           │   └── map_picker_screen.dart  # OpenStreetMap location picker (no BLoC)
│           ├── my_interests/
│           │   ├── bloc/
│           │   ├── view/my_interests_screen.dart
│           │   └── widgets/
│           │       ├── my_interest_card.dart
│           │       ├── my_interest_detail_sheet.dart
│           │       └── my_interests_empty.dart
│           ├── my_requests/
│           │   ├── bloc/
│           │   ├── view/my_requests_screen.dart
│           │   └── widgets/
│           │       ├── my_request_card.dart
│           │       ├── my_request_detail_row.dart
│           │       ├── my_request_detail_sheet.dart
│           │       ├── my_request_donor_card.dart
│           │       ├── my_request_edit_sheet.dart
│           │       └── my_request_status_badge.dart
│           ├── profile/
│           │   ├── bloc/
│           │   ├── view/
│           │   │   ├── all_badges_screen.dart
│           │   │   ├── donation_history_screen.dart
│           │   │   ├── privacy_policy_screen.dart
│           │   │   └── profile_screen.dart
│           │   └── widgets/
│           │       ├── profile_add_donation_sheet.dart
│           │       ├── profile_badges_section.dart
│           │       ├── profile_cover_photo.dart
│           │       ├── profile_donation_history.dart
│           │       ├── profile_name_and_group.dart
│           │       ├── profile_personal_info.dart
│           │       ├── profile_quick_actions.dart
│           │       ├── profile_settings_section.dart
│           │       └── profile_stats_card.dart
│           ├── registration/
│           │   ├── bloc/
│           │   ├── view/registration_screen.dart
│           │   └── widgets/
│           │       ├── registration_card_wrapper.dart
│           │       ├── registration_form_field.dart
│           │       ├── registration_selection_sheet.dart
│           │       ├── registration_step1.dart
│           │       └── registration_step2.dart
│           ├── sign_in/
│           │   ├── bloc/
│           │   └── view/sign_in_screen.dart
│           └── splash/
│               └── view/splash_screen.dart
├── data/
│   ├── mock_data.dart
│   └── repositories/
│       ├── authentication_repositories_iml.dart
│       ├── blood_request_repository_impl.dart
│       ├── chat_repository_impl.dart
│       ├── donation_repository_impl.dart
│       ├── location_repository_impl.dart
│       ├── nearby_donors_repository_impl.dart
│       └── registration_repository_iml.dart
├── di/
│   ├── di.dart                            # GetIt service locator setup
│   ├── di.config.dart                     # Auto-generated registration code
│   └── register_module.dart              # Manual Firebase + SharedPreferences providers
├── domain/
│   ├── failures/
│   │   └── failures.dart
│   ├── models/                            # 21 Freezed domain model files
│   ├── repositories/                      # 7 abstract repository interfaces
│   └── usecase/                           # 17 use case files
└── utils/
    ├── blood_compat_util.dart
    ├── donation_pdf.dart
    ├── geohash_util.dart
    ├── geo_query_util.dart
    ├── test_data_seeder.dart
    └── utils.dart
```

---

## Screens and Navigation

All navigation is handled by GoRouter. The `PAGES` enum in `routing_utils.dart` defines every route.

| Route Path | Screen | Notes |
|---|---|---|
| `/` | `SplashScreen` | Initializes auth; no BLoC |
| `/signin` | `SignInScreen` | Google Sign-In with sparkle loading overlay |
| `/register` | `RegistrationScreen()` | New user registration |
| `/home` | `BottomNavPage` | Shell for 4 tabs (Home, Donors, Messages, Profile) |
| `/createRequest` | `CreateRequestScreen` | Post a new blood request |
| `/donors` | `DonorsScreen` | Geohash-powered nearby donor search |
| `/bloodRequests` | `BloodRequestsScreen` | Browse all active requests |
| `/chats` | `ChatListScreen` | All user conversations |
| `/chat` | `ChatScreen` | Requires `ChatScreenArgs` via `extra` |
| `/profile` | `ProfileScreen` | Full profile view |
| `/editProfile` | `RegistrationScreen(initialProfile:)` | Requires `UserProfileModel` via `extra` |
| `/myRequests` | `MyRequestsScreen` | User's own blood requests |
| `/myInterests` | `MyInterestsScreen` | Requests user expressed interest in |
| `/donationHistory` | `DonationHistoryScreen` | Full donation log with PDF export |
| `/allBadges` | `AllBadgesScreen` | Requires `int` (total donations) via `extra` |
| `/privacyPolicy` | `PrivacyPolicyScreen` | In-app privacy policy |
| `/mapPicker` | `MapPickerScreen` | OpenStreetMap location picker; returns `({double lat, double lng, String address})` |

### Redirect Logic

```
!isInitialized          → /
user == null            → /signin
!profileCompleted       → /register
authed + on auth screen → /home
```

---

## Core Modules

### `AuthController` (`lib/application/core/auth/auth_controller.dart`)

`AuthController extends ChangeNotifier` — registered as `@lazySingleton`.

On initialization it runs three things in parallel:
1. A 3-second splash delay (for branding)
2. Firebase `authStateChanges()` stream (waits for first emission)
3. Location permission request (`geolocator`)

After all three complete, `isInitialized = true` and `notifyListeners()` triggers GoRouter's redirect evaluation.

Key members:
- `user` — current `firebase_auth` User
- `isLoggedIn`, `profileCompleted`, `isInitialized`
- `profile` — in-memory `UserProfileModel` set after registration/login
- `updateProfile()`, `onLoginSuccess()`, `onProfileCompleted()`, `logout()`

### `bloodRequestUrgencyConfig` (`lib/application/core/widgets/blood_request_card.dart`)

Shared map from urgency string to a config object containing `emoji`, `label`, `color`, and `bg`. Also exports:

- `formatNeedBy(DateTime)` — "Need by: Jan 15"
- `formatPosted(DateTime)` — "Posted 2 hours ago" (relative)
- `formatRequestDate(DateTime)` — "Jan 15, 2025" (absolute)

These are used across `BloodRequestCard`, `MyRequestDetailSheet`, `MyRequestCard`, and `MyRequestDetailSheet`.

### `SpService` (`lib/application/core/services/sp_service/sp_service.dart`)

Abstract typed wrapper around `SharedPreferences`. `StorageKey` enum has one key: `register` (profile-completed flag). Supports:
- `write<T>` / `read<T>` / `readSync<T>` / `delete`
- `writeList` / `readList`
- `writeRandom(key, value)` / `readRandom(key)` — used by `DonorsBloc` for per-blood-group radius caching

### Bangladesh Locations (`lib/application/core/constants/bangladesh_locations.dart`)

All 64 Bangladesh districts and their thanas/upazilas compiled directly into the Dart binary as a `Map<String, List<String>>`. Covers all 8 divisions: Barishal, Chattogram, Dhaka, Khulna, Mymensingh, Rajshahi, Rangpur, Sylhet. No JSON asset file — no runtime I/O required.

---

## Data Models

All models live in `lib/domain/models/`. Most are Freezed with `fromFirestore`/`toMap`.

### `UserProfileModel`

```
uid, fullName, gender, email, photoUrl, phone, bloodGroup,
age, lastDonation, district, thana, fbId, updatedAt,
isActive, donorTier, totalDonations
```

Computed properties: `nextDonationDate` (90 days after `lastDonation`), `daysToNextDonation`.

### `BloodRequest`

```
id, uid, patientName, bloodGroup, units, hospital, address,
urgency (CRITICAL/URGENT/NORMAL), needBy, contact, notes,
latitude?, longitude?, status (RequestStatus), createdAt, geohash
```

Freezed.

### `RequestStatus` (enum, `blood_request_enums.dart`)

`active`, `fulfilled`, `cancelled`, `expired`

### `DonorLocationModel`

Stored in `user_locations/{uid}`. Two write paths:
- `toInfoMap()` — searchable fields (name, bloodGroup, district, thana, etc.)
- `coordsMap(lat, lng)` — GPS coordinates + computed geohash field

Both use `merge: true` so neither write clobbers the other.

### `NearbyDonor`

Wraps `DonorLocationModel` + `distanceKm`. Delegating getters so UI can access fields directly without reaching into `.donor`.

### `DonationHistoryEntry`

```
id, date, hospital, bloodGroup, status, createdAt
```

Stored at `donations/{uid}/records/{docId}`.

### `InterestedDonor`

```
uid, name, bloodGroup, timestamp, lastDonation?, totalDonations
```

Stored at `blood_requests/{id}/interested_donors/{uid}`.

### `MyInterestEntry`

Pairs a `BloodRequest` with a `bloodGiven` boolean flag. Plain Dart class (not Freezed).

### `Conversation`

```
id, participantIds, participants (Map), lastMessage, lastMessageTime,
lastMessageSenderId, unreadCounts (Map), chatSource, createdAt
```

Freezed.

### `Message`

```
id, conversationId, senderId, text, type (MessageType),
timestamp, readBy, status (MessageStatus)
```

Freezed.

### `ChatSource`

```
type (ChatSourceType), referenceId?
```

Freezed.

### `ChatSourceType` (enum)

`bloodRequest`, `donorCard`, `interestResponse`, `direct`

### `MessageType` (enum)

`text`, `image`, `location`, `certificate`

### `ChatScreenArgs`

Passed to `ChatScreen` via GoRouter `extra`. Contains conversation participants, optional existing conversation ID, and the `ChatSource`.

### `LocationAddressData`

`latitude`, `longitude`, `address` string. Returned from `LocationUseCase.getAddressData()` and the map picker.

### `CreateBloodRequestParams`

DTO for posting a new request. `toMap()` adds `status: 'active'` and `createdAt: FieldValue.serverTimestamp()`.

---

## Firestore Collections

| Collection | Purpose |
|---|---|
| `profile/{uid}` | Full user profile document |
| `profile/{uid}/my_interests/{requestId}` | Requests the user expressed interest in (denormalized for fast reads) |
| `user_locations/{uid}` | Searchable donor index; geohash + info fields for geo queries |
| `blood_requests/{id}` | Posted blood requests |
| `blood_requests/{id}/interested_donors/{uid}` | Donors who responded "I'm Coming" |
| `conversations/{id}` | Chat conversation metadata |
| `conversations/{id}/messages/{msgId}` | Individual chat messages |
| `donations/{uid}/records/{docId}` | Donation history records |

**Firebase Realtime Database paths:**

| Path | Purpose |
|---|---|
| `status/{uid}` | Online presence (`online: bool`, `lastSeen: timestamp`) |
| `conversations/{convId}/typing/{uid}` | Real-time typing indicator flag |

---

## State Management

Each feature has its own BLoC. All events use Freezed sealed unions. States are Freezed unions where multiple distinct states exist, or a single `copyWith`-based class where appropriate.

| BLoC | Feature | DI |
|---|---|---|
| `SignInBloc` | sign_in | `@injectable` |
| `RegistrationBloc` | registration | `@injectable` |
| `BottomNavBloc` | bottom_nav | `@injectable` |
| `HomeBloc` | home | `@injectable` |
| `DonorsBloc` | donors | `@injectable` |
| `BloodRequestsBloc` | blood_requests | `@injectable` |
| `CreateRequestBloc` | create_request | `@injectable` |
| `MyRequestsBloc` | my_requests | `@injectable` |
| `MyInterestsBloc` | my_interests | `@injectable` |
| `ProfileBloc` | profile | instantiated manually |
| `ChatBloc` | chat | `@injectable` |
| `ConversationListBloc` | chat_list | `@injectable` |

BLoCs are provided at the screen level via `BlocProvider(create: (_) => getIt<XBloc>()..add(const XEvent.started()))`. Listeners and builders are in the `_XView` private widget directly below.

### Notable BLoC Behaviors

**`HomeBloc.started`** — loads user profile, fires GPS update (fire-and-forget via `unawaited`), fetches nearby donors within 100 km, fetches up to 5 active requests, and loads the user's interest IDs.

**`DonorsBloc`** — implements radius-ring pagination (10 → 20 → 40 → 80 → +50 km steps to 1000 km). Caches the last successful radius per blood group in SharedPreferences so the next search for that blood group starts near where the previous one found results.

**`ChatBloc`** — on `openRequested`: creates or fetches conversation, starts three concurrent Firestore/RTDB stream subscriptions (messages, presence, typing), sets online status in RTDB. Typing indicator has a 5-second idle timeout before clearing. Marks messages read on open and on each new batch.

**`MyRequestsBloc`** — on `started`/`refreshed`: batch-updates all past-due active requests to `expired` status before loading the list.

**`MyInterestsBloc`** — on `bloodGivenMarked`: guards with `isBloodGroupCompatible()` before writing to Firestore; on success, automatically creates a `DonationHistoryEntry` and the use case atomically updates `totalDonations`, `lastDonation`, `donorTier`, and `isActive` in both `profile` and `user_locations` collections.

---

## Dependency Injection

`get_it` + `injectable`. The DI graph is built in `main.dart` before `runApp`.

```dart
// di/register_module.dart — manual providers
@module
abstract class RegisterModule {
  @singleton FirebaseAuth get auth => FirebaseAuth.instance;
  @singleton FirebaseFirestore get firestore => FirebaseFirestore.instance;
  @singleton FirebaseDatabase get database => FirebaseDatabase.instance;
  @singleton GoogleSignIn get googleSignIn => GoogleSignIn.instance;
  @preResolve Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
```

All BLoC classes are `@injectable`. Repository implementations are `@Injectable(as: AbstractRepo)`. `AuthController` and `AppRouter` are `@lazySingleton`. `SpServiceImpl` is `@LazySingleton(as: SpService)`.

Usage in screens:

```dart
BlocProvider(
  create: (_) => getIt<MyRequestsBloc>()..add(const MyRequestsEvent.started()),
  child: const _MyRequestsView(),
)
```

---

## Routing

`AppRouter` is a `@lazySingleton` that holds the `GoRouter` instance. Navigation is done via:

```dart
// Imperative push from non-widget context (e.g., inside a BLoC callback):
AppRouter.router.push(PAGES.myRequests.screenPath);

// From a widget BuildContext (GoRouter extension):
context.push(PAGES.privacyPolicy.screenPath);

// With extra data:
AppRouter.router.push(PAGES.editProfile.screenPath, extra: profile);
context.push(PAGES.allBadges.screenPath, extra: totalDonations);
```

The static `AppRouter.router` getter resolves to `getIt<AppRouter>()._goRouter` for backward compatibility with call sites that don't have a `BuildContext`.

---

## Firebase Integration

### Firebase Auth

Google Sign-In with `FirebaseAuth` + `google_sign_in`. `AuthController` wraps `authStateChanges()` and acts as GoRouter's `refreshListenable` so any auth state change automatically re-evaluates redirect rules.

### Cloud Firestore

Primary database for all persistent data. Real-time stream subscriptions used for chat messages, conversation list, and presence-related metadata. Paginated queries for blood requests (cursor on `needBy` field). Geohash range queries for donor search.

Key write patterns:
- **Dual write** (atomic batch) on donor registration and profile edit: writes to both `profile/{uid}` and `user_locations/{uid}` simultaneously
- **Transaction** on `addDonation`: atomically increments `totalDonations`, updates `lastDonation`, recomputes `donorTier`, and sets `isActive: true` in both `profile` and `user_locations` collections
- **Batch write** on "I'm Coming": writes to `blood_requests/{id}/interested_donors/{uid}` and `profile/{uid}/my_interests/{requestId}` in one operation
- **Batch delete** on withdraw interest: removes both subcollection entries atomically

### Firebase Realtime Database

Used exclusively for low-latency ephemeral state:
- Online presence at `status/{uid}` — set to `{online: true}` on chat open, `{online: false, lastSeen: timestamp}` on close
- Typing indicator at `conversations/{convId}/typing/{uid}` — true/false flag with 5-second idle timeout

### Planned (not yet active)

- **Firebase Cloud Messaging (FCM)** — push notifications for incoming messages and new blood requests nearby
- **Firebase Storage** — photo upload for chat attachments and profile pictures
- **Cloud Functions** — server-side automation (e.g., auto-expire stale requests, fan-out notifications)

---

## UI Design System

### Colors (`lib/application/core/theme/colors.dart`)

| Token | Value | Usage |
|---|---|---|
| `primary` | `#E53935` | Buttons, icons, accents |
| `primaryDark` | `#B71C1C` | Gradient start, dark accents |
| `primaryDarker` | `#C62828` | Intermediate gradient stop |
| `primaryLight` | `#EF9A9A` | Light borders, soft highlights |
| `primarySurface` | `#FFEBEE` | Card backgrounds |
| `primarySurfaceLight` | `#FFF5F5` | Very light surface tint |
| `primaryBorder` | `#FFCDD2` | Dividers and card borders |
| `background` | `#F5F5F5` | App background |
| `textPrimary` | `#212121` | Headings |
| `textSecondary` | `#424242` | Body text |
| `textTertiary` | `#757575` | Labels, secondary info |
| `textMuted` | `#9E9E9E` | Placeholders |
| `success` | `#43A047` | Success states, active status |
| `warning` | `#FB8C00` | Urgent badges |
| `info` | `#1E88E5` | Edit Profile action card |
| `gold` | `#FFD700` | Gold tier badge |
| `bronze` | `#CD7F32` | Bronze tier badge |
| `silver` | `#A8A9AD` | Silver tier badge |

Avatar colors (blue, green, red, orange, purple, teal) are used for initial-based avatar backgrounds when no photo is available.

### Typography

Poppins font family set via `ThemeData.fontFamily = AppColors.fontFamily`. Font weight usage: `w400` (body), `w500` (medium emphasis), `w600` (semi-bold labels), `w700` (headings).

### Key UI Patterns

- **Card containers** — `borderRadius: 16`, white background, `BoxShadow(color: black.withValues(alpha: 0.06), blurRadius: 6–16, offset: Offset(0, 1–6))`
- **Primary buttons** — `AppColors.primary` background, white text, `borderRadius: 14–24`, elevation 0–4
- **Urgency chips** — CRITICAL (red), URGENT (orange), NORMAL (green), each with matching background and foreground
- **Status badges** — small pill containers with colored border and text
- **Gradient headers** — `LinearGradient(colors: [#7B0000, primaryDark, primary])` on profile cover and quote card
- **Frosted glass overlays** — `Colors.white.withValues(alpha: 0.18)` background with `Colors.white.withValues(alpha: 0.3)` border; used for blood group pill and status badge on profile cover
- **Wave clip** — `ClipPath` with a `CustomClipper<Path>` using two `quadraticBezierTo` calls for the profile cover photo bottom edge
- **`withValues(alpha:)`** — used everywhere instead of the deprecated `withOpacity()` to avoid lint warnings

---

## Utilities

### `blood_compat_util.dart`

Whole-blood compatibility map (donor → set of compatible recipient blood groups). `isBloodGroupCompatible(donor, recipient)` — called in `MyInterestsBloc` before allowing "Mark Blood Given" and used in `BloodRequestCard`/`HomeActiveRequests` to highlight compatible requests.

### `geohash_util.dart`

Pure Dart geohash encoder (base32, configurable precision up to 9 characters). Called from `DonorLocationModel.coordsMap()` when writing GPS coordinates to `user_locations`.

### `geo_query_util.dart`

Port of the `geofire-common` `geohashQueryBounds` algorithm. Computes up to 9 `GeohashRange` intervals (center + 8 neighbours) needed to cover a circular search area with Firestore `orderBy`/`startAt`/`endAt` range queries. Also provides `distanceKm(lat1, lng1, lat2, lng2)` via Geolocator's Haversine implementation.

### `donation_pdf.dart`

Generates a multi-page A4 PDF via the `pdf` package containing donor profile info, earned badges, and the full donation history table. Shares the result via the `printing` package. Entry point: `generateAndShareDonationPdf({profile, history})`.

### `utils.dart`

`Utils` class with static helpers:
- `showSnackBar(context, content, color)` — themed snackbar
- `showConfirmDialog(context, title, message, confirmLabel)` → `Future<bool>`
- `showSuccessDialog` / `showErrorDialog`
- `launchUrl(url)` — opens URL via `url_launcher`
- `facebookUrl(input)` — normalizes a bare username or full URL to `https://www.facebook.com/{username}`

### `test_data_seeder.dart`

Development utility that seeds Firestore with sample donor profiles, blood requests, and donation records for local testing.

---

## Getting Started

### Prerequisites

- Flutter SDK with Dart `^3.11.5`
- Firebase project with **Firestore**, **Authentication (Google provider)**, and **Realtime Database** enabled
- `google-services.json` placed at `android/app/google-services.json`

### Installation

```bash
git clone <repo-url>
cd blood_setu
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

### Code Generation

Freezed models, injectable DI, and JSON serialization all require code generation. Run this whenever you add or modify any `@freezed`, `@injectable`, or `@JsonSerializable` annotated class:

```bash
dart run build_runner build --delete-conflicting-outputs
```

For continuous watch mode during development:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

---

## Platform Support

| Platform | Scaffold | Firebase Configured | Status |
|---|---|---|---|
| Android | Yes | Yes | Fully functional |
| iOS | Yes | No | Needs `GoogleService-Info.plist` |
| Web | Yes | No | Needs FlutterFire CLI reconfigure |
| Linux | Yes | No | Needs FlutterFire CLI reconfigure |
| macOS | Yes | No | Needs FlutterFire CLI reconfigure |
| Windows | Yes | No | Needs FlutterFire CLI reconfigure |

To configure additional platforms, run:

```bash
flutterfire configure
```

---

## Contributing

### Widget Extraction Pattern

Each feature folder follows a consistent three-folder structure:

```
feature/
├── bloc/        # BLoC, Event, State (Freezed)
├── view/        # Main screen file (BlocProvider + scaffold, ≤150 lines)
└── widgets/     # Extracted widget classes (public, named)
```

When extracting a widget from a screen file into `widgets/`:
- Import depth from `widgets/` to `application/` is 4 levels (`../../../../`)
- Import depth from `widgets/` to `lib/` root is 5 levels (`../../../../../`)
- `di/di.dart` is at `lib/di/di.dart`, not under `application/`

### Code Standards

- Use `AppColors` for all colors — never hard-code color values
- Use `color.withValues(alpha: value)` instead of `color.withOpacity(value)`
- All new domain models must be Freezed with `fromFirestore`/`toMap`
- All new features must have a BLoC with Freezed events and states
- BLoCs depend only on use cases; use cases depend only on abstract repository interfaces
- Run `flutter analyze` before committing — zero warnings/errors required

### Use Case Pattern

```dart
class MyUseCase {
  final MyRepository _repo;
  MyUseCase(this._repo);

  Future<Either<Failure, Result>> call(Params params) async {
    try {
      final result = await _repo.doSomething(params);
      return Right(result);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
```
