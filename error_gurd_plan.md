# Error `guard()` Plan — Blood Setu

## Context

The data layer repeats the **same `try / on FirebaseException / catch` block 27 times** across 7
repository implementations. The case study below surfaced three problems:

1. **Duplication** — ~290 lines of near-identical error-wrapping boilerplate.
2. **Silent swallowing** — every catch-all discards the real exception (no log), so production
   failures are invisible.
3. **Inconsistent + unsafe UX** — some catch-alls return a friendly static message, others leak the
   raw exception to the UI (`GeneralFailure(e.toString())` in `getProfile`, `signInWithGoogle`,
   `register`/`signOut`).

**Outcome:** one tested helper that removes the boilerplate, logs every real error, and gives a
consistent friendly message — without changing the `Either<Failure,T>` contract the blocs rely on.

---

## Case Study — what the 7 repos actually do

Files (all under `lib/data/repositories/`):

| Repo | Methods | Error variants observed |
|---|---|---|
| `nearby_donors_repository_impl.dart` | 3 | `on FirebaseException → GeneralFailure(e.message ?? fb)`, `catch(_) → GeneralFailure(static)` |
| `blood_request_repository_impl.dart` | ~7 | same; 12 try-blocks |
| `donation_repository_impl.dart` | 3 | same (incl. a `runTransaction`) |
| `location_repository_impl.dart` | several | same |
| `chat_repository_impl.dart` | mixed | **mostly returns plain values/Futures, not `Either`** → OUT OF SCOPE |
| `authentication_repositories_iml.dart` | 2 | `on FirebaseAuthException`, plus `catch(e) → GeneralFailure(e.toString())` ⚠ leaks raw error |
| `registration_repository_iml.dart` | 2 | `on FirebaseAuthException` + `on FirebaseException` + `catch(e) → e.toString()` ⚠ |

**Three facts that decide the design:**

- **Inline validation `Left`s exist inside the `try`** — e.g. `Left(GeneralFailure('Profile not found.'))`,
  `Left(GeneralFailure('User is null'))`. The helper **must let these pass through unchanged**.
- **`FirebaseAuthException extends FirebaseException`** — one `on FirebaseException` clause covers
  auth too, and still exposes `e.message`.
- Every repo maps only to `GeneralFailure`, and the bloc special-cases only `GeneralFailure`
  (`f is GeneralFailure ? f.message : 'Something went wrong.'`), so mapping to `GeneralFailure`
  preserves current UI behavior.

---

## Ideal Solution (decided)

A **top-level `guard<T>()` function** whose body **returns `Either<Failure,T>`** — the least
invasive option that fixes all three problems. Bodies keep their `return Right(x)` and inline
`return Left(...)` lines; only the repetitive `try/catch` is deleted. A top-level function (not a
mixin/base class) avoids inheritance coupling across the 7 unrelated abstract repo types. The
catch-all returns the friendly `fallback` (not `e.toString()`), killing the raw-error leak, while
`debugPrint` sends the real exception + stack to the console.

### New file: `lib/data/repositories/repo_guard.dart`

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../domain/failures/failures.dart';

/// Wraps a repository body so the repetitive Firebase error handling lives in
/// one place. The [body] returns an [Either] so callers keep their own inline
/// validation `Left`s (e.g. "Profile not found.") untouched.
Future<Either<Failure, T>> guard<T>(
  Future<Either<Failure, T>> Function() body, {
  required String fallback,
}) async {
  try {
    return await body();
  } on FirebaseException catch (e, st) {
    debugPrint('[Repo] FirebaseException(${e.code}): ${e.message}\n$st');
    return Left(GeneralFailure(e.message ?? fallback));
  } catch (e, st) {
    debugPrint('[Repo] Unexpected: $e\n$st');
    return Left(GeneralFailure(fallback));
  }
}
```

### Refactor pattern

```dart
// Before
Future<Either<Failure, UserProfileModel>> getProfile(String uid) async {
  try {
    final doc = await _firebaseFirestore.collection('profile').doc(uid).get();
    if (!doc.exists) return Left(GeneralFailure('Profile not found.'));
    return Right(UserProfileModel.fromFirestore(doc));
  } on FirebaseException catch (e) {
    return Left(GeneralFailure(e.message ?? 'Failed to load profile.'));
  } catch (e) {
    return Left(GeneralFailure(e.toString())); // ⚠ leaks raw error
  }
}

// After
Future<Either<Failure, UserProfileModel>> getProfile(String uid) =>
    guard(() async {
      final doc = await _firebaseFirestore.collection('profile').doc(uid).get();
      if (!doc.exists) return Left(GeneralFailure('Profile not found.'));
      return Right(UserProfileModel.fromFirestore(doc));
    }, fallback: 'Failed to load profile.');
```

---

## Behavior changes (intentional, all improvements)

1. Raw `e.toString()` is **no longer shown to users** (auth + registration + profile) — friendly `fallback` instead.
2. Every caught error is now **logged** via `debugPrint` (was silently swallowed).
3. No change to `Either<Failure,T>` types, method signatures, or bloc consumption.

---

## Tasks & Sub-tasks

### Task 1 — Create the `guard()` helper
- [ ] 1.1 Create `lib/data/repositories/repo_guard.dart`.
- [ ] 1.2 Add imports: `cloud_firestore`, `dartz`, `flutter/foundation`, `domain/failures/failures.dart`.
- [ ] 1.3 Implement `Future<Either<Failure, T>> guard<T>(Future<Either<Failure,T>> Function() body, {required String fallback})`.
- [ ] 1.4 Catch `FirebaseException` → `debugPrint` (code + message + stack) → `Left(GeneralFailure(e.message ?? fallback))`.
- [ ] 1.5 Catch-all → `debugPrint(error + stack)` → `Left(GeneralFailure(fallback))` (no raw `e.toString()` to UI).
- [ ] 1.6 Add a doc comment explaining body-returns-`Either` and the logging behavior.

### Task 2 — Refactor `nearby_donors_repository_impl.dart`
- [ ] 2.1 Import `repo_guard.dart`.
- [ ] 2.2 Wrap `getTotalDonorCount` — `fallback: 'Failed to get donor count.'`.
- [ ] 2.3 Wrap `getOrigin` (keep inline `Left` for missing lat/lng) — `fallback: 'Failed to read your location.'`.
- [ ] 2.4 Wrap `getNearbyDonors` — `fallback: 'Failed to load nearby donors.'`.
- [ ] 2.5 Delete all replaced `try/on FirebaseException/catch` blocks.

### Task 3 — Refactor `blood_request_repository_impl.dart`
- [ ] 3.1 Import `repo_guard.dart`.
- [ ] 3.2 Wrap every `Either`-returning method (createRequest, getActiveRequests, getMyRequests, updateRequest, + interest/mark methods) reusing each method's existing fallback string.
- [ ] 3.3 Preserve in-`try` query building and any inline `Left`s.
- [ ] 3.4 Delete replaced try/catch blocks (12 sites).

### Task 4 — Refactor `donation_repository_impl.dart`
- [ ] 4.1 Import `repo_guard.dart`.
- [ ] 4.2 Wrap `addDonation` — entire `runTransaction(...)` sits inside `body`; `fallback: 'Failed to record donation.'`.
- [ ] 4.3 Wrap `getDonationHistory` — `fallback: 'Failed to load donation history.'`.
- [ ] 4.4 Wrap `reactivateDonor` — `fallback: 'Failed to reactivate donor.'`.
- [ ] 4.5 Keep `_computeTier` untouched.

### Task 5 — Refactor `location_repository_impl.dart`
- [ ] 5.1 Import `repo_guard.dart`.
- [ ] 5.2 Wrap each `Either`-returning method with its existing fallback string.
- [ ] 5.3 Preserve any GPS/permission inline `Left`s.
- [ ] 5.4 Delete replaced try/catch blocks.

### Task 6 — Refactor `authentication_repositories_iml.dart`
- [ ] 6.1 Import `repo_guard.dart`.
- [ ] 6.2 Wrap `signInWithGoogle` — keep inline `Left(GeneralFailure('User is null'))`; `fallback: 'Firebase authentication failed'`.
- [ ] 6.3 Wrap `signOut` — `fallback: 'An unexpected error occurred during sign out.'`.
- [ ] 6.4 Remove the raw-leak `catch(e) → e.toString()` (now handled by guard).

### Task 7 — Refactor `registration_repository_iml.dart`
- [ ] 7.1 Import `repo_guard.dart`.
- [ ] 7.2 Wrap `register` — keep inline no-session `Left`; collapse the auth+db+catch trio into one guard; `fallback: 'An unexpected error occurred during registration. Please try again.'`.
- [ ] 7.3 Wrap `getProfile` — keep inline `Left(GeneralFailure('Profile not found.'))`; remove raw-leak catch; `fallback: 'Failed to load profile.'`.

### Task 8 — Confirm exclusion
- [ ] 8.1 Verify `chat_repository_impl.dart` is **untouched** (non-`Either` methods, out of scope).

### Task 9 — Verify
- [ ] 9.1 `flutter analyze` → zero issues.
- [ ] 9.2 `dart run build_runner build --delete-conflicting-outputs`.
- [ ] 9.3 Manual smoke tests: Google sign-in; Find Donors (location ON/OFF); profile exists + missing; add donation; create/load requests.
- [ ] 9.4 Force an offline failure → confirm friendly UI message **and** `[Repo] ...` console log.

### Task 10 — Follow-up (optional, separate change)
- [ ] 10.1 Add `test/data/repo_guard_test.dart` with a throwing fake body asserting `Left(GeneralFailure)` + fallback message.

---

## Edge cases handled
- Inline validation `Left`s (Profile not found / User is null / no-session) pass through unchanged.
- `runTransaction` in donation repo works as-is inside `body`.
- Registration's two distinct fallbacks collapse to one; server `e.message` still shown when present.
