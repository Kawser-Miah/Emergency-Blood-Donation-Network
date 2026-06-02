import 'package:dartz/dartz.dart';

import '../failures/failures.dart';
import '../models/nearby_donor.dart';

abstract class NearbyDonorsRepository {
  /// Returns the total number of documents in user_locations using Firestore
  /// count() — does not read any documents, just the count.
  Future<Either<Failure, int>> getTotalDonorCount();

  /// Resolves the searching user's own coordinates (from `user_locations/{uid}`,
  /// which is refreshed on every app open). Used as the origin for the search.
  Future<Either<Failure, ({double latitude, double longitude})>> getOrigin(
    String uid,
  );

  /// Returns donors within [radiusKm] of ([latitude], [longitude]), sorted by
  /// ascending distance. When [bloodGroup] is non-null/non-empty it is applied
  /// at the query level (requires a `bloodGroup + geohash` composite index).
  /// [excludeUid] drops the searching user from the results.
  Future<Either<Failure, List<NearbyDonor>>> getNearbyDonors({
    required double latitude,
    required double longitude,
    required double radiusKm,
    String? bloodGroup,
    String? excludeUid,
  });
}
