// Unit tests for the shared repository `guard()` helper.
//
// These run on a plain `flutter test` runner — no Firebase platform binding is
// needed, since `FirebaseException` is a plain Dart class that can be thrown
// directly.

import 'package:blood_setu/data/repositories/repo_guard.dart';
import 'package:blood_setu/domain/failures/failures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const fallback = 'Something friendly happened.';

  group('guard()', () {
    test('passes a Right through unchanged', () async {
      final result = await guard<int>(
        () async => const Right(42),
        fallback: fallback,
      );
      expect(result, const Right<Failure, int>(42));
    });

    test('passes an inline validation Left through unchanged', () async {
      final result = await guard<int>(
        () async => Left(GeneralFailure('Profile not found.')),
        fallback: fallback,
      );
      result.fold(
        (f) => expect((f as GeneralFailure).message, 'Profile not found.'),
        (_) => fail('expected a Left'),
      );
    });

    test('maps a generic exception to GeneralFailure(fallback)', () async {
      final result = await guard<int>(
        () async => throw Exception('boom — raw error must not leak'),
        fallback: fallback,
      );
      result.fold(
        (f) {
          expect(f, isA<GeneralFailure>());
          expect((f as GeneralFailure).message, fallback);
        },
        (_) => fail('expected a Left'),
      );
    });

    test('surfaces FirebaseException.message when present', () async {
      final result = await guard<int>(
        () async => throw FirebaseException(
          plugin: 'firestore',
          code: 'permission-denied',
          message: 'Missing or insufficient permissions.',
        ),
        fallback: fallback,
      );
      result.fold(
        (f) {
          expect(f, isA<GeneralFailure>());
          expect(
            (f as GeneralFailure).message,
            'Missing or insufficient permissions.',
          );
        },
        (_) => fail('expected a Left'),
      );
    });

    test('falls back when FirebaseException.message is null', () async {
      final result = await guard<int>(
        () async => throw FirebaseException(plugin: 'firestore'),
        fallback: fallback,
      );
      result.fold(
        (f) => expect((f as GeneralFailure).message, fallback),
        (_) => fail('expected a Left'),
      );
    });
  });
}
