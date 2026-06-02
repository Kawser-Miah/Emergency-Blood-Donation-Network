import 'package:blood_setu/domain/failures/failures.dart';
import 'package:blood_setu/domain/models/nearby_donor.dart';
import 'package:blood_setu/domain/repositories/nearby_donors_repository.dart';
import 'package:blood_setu/utils/geo_query_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NearbyDonorsRepository)
class NearbyDonorsRepositoryImpl extends NearbyDonorsRepository {
  final FirebaseFirestore _firestore;

  NearbyDonorsRepositoryImpl(this._firestore);

  @override
  Future<Either<Failure, int>> getTotalDonorCount() async {
    try {
      final snap = await _firestore.collection('user_locations').count().get();
      return Right(snap.count ?? 0);
    } on FirebaseException catch (e) {
      return Left(GeneralFailure(e.message ?? 'Failed to get donor count.'));
    } catch (_) {
      return Left(GeneralFailure('Failed to get donor count.'));
    }
  }

  @override
  Future<Either<Failure, ({double latitude, double longitude})>> getOrigin(
    String uid,
  ) async {
    try {
      final doc = await _firestore.collection('user_locations').doc(uid).get();
      final data = doc.data();
      final lat = (data?['latitude'] as num?)?.toDouble();
      final lng = (data?['longitude'] as num?)?.toDouble();
      if (lat == null || lng == null) {
        return Left(
          GeneralFailure(
            "Your location isn't available yet. Please make sure GPS is on and try again.",
          ),
        );
      }
      return Right((latitude: lat, longitude: lng));
    } on FirebaseException catch (e) {
      return Left(GeneralFailure(e.message ?? 'Failed to read your location.'));
    } catch (_) {
      return Left(GeneralFailure('Failed to read your location.'));
    }
  }

  @override
  Future<Either<Failure, List<NearbyDonor>>> getNearbyDonors({
    required double latitude,
    required double longitude,
    required double radiusKm,
    String? bloodGroup,
    String? excludeUid,
  }) async {
    try {
      final radiusMeters = radiusKm * 1000;
      final bounds = GeoQueryUtil.queryBounds(
        latitude,
        longitude,
        radiusMeters,
      );
      final collection = _firestore.collection('user_locations');

      // One query per covering geohash range, run concurrently.
      final futures = bounds.map((range) {
        Query<Map<String, dynamic>> query = collection;
        if (bloodGroup != null && bloodGroup.isNotEmpty) {
          query = query.where('bloodGroup', isEqualTo: bloodGroup);
        }
        return query.orderBy('geohash').startAt([range.start]).endAt([
          range.end,
        ]).get();
      });

      final snapshots = await Future.wait(futures);

      // Merge + dedupe by uid, compute true distance, drop docs outside the
      // radius (geohash cells overshoot the circle) and the searcher.
      final byUid = <String, NearbyDonor>{};
      for (final snap in snapshots) {
        for (final doc in snap.docs) {
          if (doc.id == excludeUid || byUid.containsKey(doc.id)) continue;
          final data = doc.data();
          final lat = (data['latitude'] as num?)?.toDouble();
          final lng = (data['longitude'] as num?)?.toDouble();
          if (lat == null || lng == null) continue;
          final dKm = GeoQueryUtil.distanceKm(latitude, longitude, lat, lng);
          if (dKm > radiusKm) continue;
          byUid[doc.id] = NearbyDonor.fromLocationDoc(doc, dKm);
        }
      }

      final donors = byUid.values.toList()
        ..sort((a, b) => a.distanceKm.compareTo(b.distanceKm));

      return Right(donors);
    } on FirebaseException catch (e) {
      return Left(GeneralFailure(e.message ?? 'Failed to load nearby donors.'));
    } catch (_) {
      return Left(GeneralFailure('Failed to load nearby donors.'));
    }
  }
}
