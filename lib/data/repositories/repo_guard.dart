import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../domain/failures/failures.dart';

/// Wraps a repository body so the repetitive Firebase error handling lives in
/// one place.
///
/// The [body] itself returns an [Either] (rather than a raw value) so callers
/// keep their own inline validation `Left`s — e.g.
/// `return Left(GeneralFailure('Profile not found.'))` — completely untouched.
/// Only the surrounding `try / on FirebaseException / catch` boilerplate is
/// removed.
///
/// Behavior:
/// - Every caught error is logged via [debugPrint] (real exception + stack), so
///   production failures are no longer silently swallowed.
/// - `FirebaseException` (which `FirebaseAuthException` extends) surfaces the
///   server `e.message` when present, otherwise the friendly [fallback].
/// - Any other exception maps to the friendly [fallback] — the raw
///   `e.toString()` is never leaked to the UI.
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
