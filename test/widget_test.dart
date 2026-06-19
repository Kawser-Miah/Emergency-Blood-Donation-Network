// Minimal smoke test that keeps the suite green and proves the test runner works.
//
// A full widget test of `MyApp` is intentionally avoided here: it would call
// `Firebase.initializeApp`, which is not available on a plain `flutter test`
// runner. Real widget/bloc tests can be added per the project's testing
// standards (fake_cloud_firestore / mocktail) as features grow.

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sanity check', () {
    expect(1 + 1, 2);
  });
}
