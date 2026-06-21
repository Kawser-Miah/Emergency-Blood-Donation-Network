# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.
## Commands

```bash
# Install dependencies
flutter pub get

# Run the app (Android device/emulator required for Firebase)
flutter run

# Code generation (Freezed, injectable, json_serializable) — run after any change to annotated classes
dart run build_runner build --delete-conflicting-outputs

# Watch mode during development
dart run build_runner watch --delete-conflicting-outputs

# Lint (must be zero warnings/errors before committing)
flutter analyze

# Tests
flutter test
flutter test test/widget_test.dart  # run a single test file
```

## Architecture

Clean Architecture with BLoC state management, three layers:

**Presentation** (`lib/application/`): Feature folders under `pages/features/` each have `bloc/`, `view/` (one screen file ≤150 lines), and `widgets/`. Shared code lives in `core/` (auth, routing, theme, widgets, constants).

**Domain** (`lib/domain/`): Pure Dart. Models (Freezed), use cases (single-responsibility, return `Either<Failure, T>`), and abstract repository interfaces. `dartz` is used for functional error handling everywhere.

**Data** (`lib/data/repositories/`): Concrete Firebase/GPS implementations, registered with `@Injectable(as: AbstractInterface)`. Every `Either`-returning method wraps its body in the shared `guard()` helper (`repo_guard.dart`) instead of hand-written try/catch.

**DI** (`lib/di/`): `get_it` + `injectable`. `di.config.dart` is auto-generated — never edit it manually. `register_module.dart` manually provides Firebase instances and `SharedPreferences`. BLoCs are `@injectable`; singletons are `@lazySingleton`.

## Key Invariants

**Code generation**: Any `@freezed`, `@injectable`, or `@JsonSerializable` change requires re-running `build_runner`. Generated files (`*.freezed.dart`, `*.g.dart`, `di.config.dart`) must be committed.

**Dual-write pattern**: `profile/{uid}` (full user data) and `user_locations/{uid}` (searchable donor index) are always written together in an atomic batch. Never write to one without the other when updating fields that exist in both.

**`user_locations` geohash**: GPS coordinates are written via `LocationRepository.updateGps()` using `SetOptions(merge: true)` so they don't clobber the info fields written during registration. `DonorLocationModel.coordsMap()` computes the geohash via `GeohashUtil`.

**Donation write**: Adding a donation uses a Firestore transaction that atomically updates `totalDonations`, `lastDonation`, `donorTier`, and `isActive` in both `profile` and `user_locations`.

**Auth flow**: `AuthController` is a `ChangeNotifier` and is `GoRouter`'s `refreshListenable`. It initializes in parallel: 3-second splash delay + Firebase auth state + location permission. Redirect rules: uninitialized → splash; no user → sign-in; no profile → registration; authed → home.

**Geohash donor search**: `GeoQueryUtil.queryBounds()` returns up to 9 Firestore range intervals covering a circle (center + 8 neighbors). Each interval runs as a separate Firestore query; results are merged, deduped, and filtered by true Haversine distance. `DonorsBloc` uses radius-ring pagination (10→20→40→80→+50 km steps) with per-blood-group radius cached in `SharedPreferences`.

**Chat presence**: Real-time Database (not Firestore) is used for `presence/{uid}` (online/lastSeen) and `typing/{convId}/{uid}`. `onDisconnect()` handlers ensure state is cleaned up on sudden disconnects.

**Foreground chat notifications**: `flutter_local_notifications` (v18.0.1) shows Android heads-up notifications when a new message arrives. Detection happens in `ConversationListBloc` via unread count delta. `NotificationService` (`@lazySingleton`, `@PostConstruct(preResolve: true)`) owns channel creation, show logic, and tap routing. `ChatBloc` registers/clears the active conversation ID so notifications are suppressed while the user is inside the relevant chat. Full documentation: [`doc/notification_system.md`](doc/notification_system.md).

**Repository error handling (`guard()`)**: Every `Either`-returning repository method wraps its body in the shared `guard<T>(body, {required fallback})` helper in `lib/data/repositories/repo_guard.dart`. Do NOT hand-write `try / on FirebaseException / catch` in repositories. The `body` returns an `Either`, so inline validation `Left`s (e.g. `Left(GeneralFailure('Profile not found.'))`) pass through untouched. `guard` logs the real exception + stack via `debugPrint('[Repo] ...')` and returns `Left(GeneralFailure(e.message ?? fallback))` for `FirebaseException` (which covers `FirebaseAuthException`) or `Left(GeneralFailure(fallback))` otherwise — never `e.toString()` to the UI. `runTransaction`/batch writes work as-is inside the body. `chat_repository_impl.dart` is excluded (returns plain values/streams, not `Either`). Covered by `test/data/repo_guard_test.dart`.

## Firestore Collections

| Collection | Purpose |
|---|---|
| `profile/{uid}` | Full user profile |
| `profile/{uid}/my_interests/{requestId}` | Denormalized interest records |
| `user_locations/{uid}` | Geohash-indexed donor search index |
| `blood_requests/{id}` | Active/expired blood requests |
| `blood_requests/{id}/interested_donors/{uid}` | Donor interest responses |
| `conversations/{id}` | Chat metadata |
| `conversations/{id}/messages/{msgId}` | Chat messages |
| `donations/{uid}/records/{docId}` | Manual donation history entries |

## Coding Conventions

- All colors from `AppColors` — never hard-code color values
- Use `color.withValues(alpha: value)` — not the deprecated `withOpacity()`
- New domain models: Freezed + `fromFirestore`/`toMap`/`copyWith`
- New features: BLoC with Freezed events and states
- BLoCs depend only on use cases; use cases depend only on abstract repository interfaces
- `Either<Failure, T>` for all repository and use case return types
- Repository `Either` methods wrap their body in `guard()` (see Key Invariants) — no hand-written try/catch, no raw `e.toString()` returned to the UI
- BLoCs are provided at screen level via `BlocProvider(create: (_) => getIt<XBloc>()..add(const XEvent.started()))`

## Import Depth from `widgets/` subdirectory

Widgets inside `application/pages/features/X/widgets/` need these relative paths:
- Back to `application/`: `../../../../`
- Back to `lib/` root: `../../../../../`
- `di/di.dart` is at `lib/di/di.dart` (not under `application/`)

## Navigation

All routes defined in `PAGES` enum (`routing_utils.dart`). Static `AppRouter.router` getter resolves from `getIt<AppRouter>()` for use outside `BuildContext`. Pass route data via `extra`:

```dart
AppRouter.router.push(PAGES.editProfile.screenPath, extra: profileModel);
context.push(PAGES.chat.screenPath, extra: ChatScreenArgs(...));
```

`/chat` requires `ChatScreenArgs` as `extra`; `/editProfile` requires `UserProfileModel`; `/allBadges` requires `int` (total donations); `/mapPicker` accepts `({double? initialLat, double? initialLng})`. 