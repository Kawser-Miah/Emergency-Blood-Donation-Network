import 'package:blood_setu/domain/failures/failures.dart';
import 'package:blood_setu/domain/models/donation_history_entry.dart';
import 'package:blood_setu/domain/repositories/donation_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DonationRepository)
class DonationRepositoryImpl extends DonationRepository {
  final FirebaseFirestore _firestore;

  DonationRepositoryImpl(this._firestore);

  @override
  Future<Either<Failure, void>> addDonation(
    String uid,
    DonationHistoryEntry entry,
  ) async {
    try {
      final profileRef = _firestore.collection('profile').doc(uid);
      final locationRef = _firestore.collection('user_locations').doc(uid);
      final recordsRef = _firestore
          .collection('donations')
          .doc(uid)
          .collection('records');

      await _firestore.runTransaction((tx) async {
        final profileSnap = await tx.get(profileRef);
        final data = profileSnap.data() ?? {};

        final currentCount = (data['totalDonations'] as num?)?.toInt() ?? 0;
        final newCount = currentCount + 1;
        final tier = _computeTier(newCount);

        // Only advance lastDonation — never overwrite a newer date with an
        // older one (donor may be recording a past donation retroactively).
        final currentLastDonation = data['lastDonation'] != null
            ? (data['lastDonation'] as Timestamp).toDate()
            : null;
        final effectiveLastDonation =
            currentLastDonation == null ||
                entry.date.isAfter(currentLastDonation)
            ? entry.date
            : currentLastDonation;

        // Donor must wait 90 days between donations. If the effective last
        // donation falls within that window, mark them inactive.
        final threeMonthsAgo = DateTime.now().subtract(
          const Duration(days: 90),
        );
        final isActive = effectiveLastDonation.isBefore(threeMonthsAgo);

        tx.set(recordsRef.doc(), entry.toMap());

        tx.update(profileRef, {
          'totalDonations': newCount,
          'lastDonation': Timestamp.fromDate(effectiveLastDonation),
          'donorTier': tier,
          'isActive': isActive,
        });

        // Sync the same fields to user_locations (the searchable donor index).
        tx.set(locationRef, {
          'totalDonations': newCount,
          'donorTier': tier,
          'isActive': isActive,
        }, SetOptions(merge: true));
      });

      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(GeneralFailure(e.message ?? 'Failed to record donation.'));
    } catch (_) {
      return Left(GeneralFailure('Failed to record donation.'));
    }
  }

  @override
  Future<Either<Failure, List<DonationHistoryEntry>>> getDonationHistory(
    String uid,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('donations')
          .doc(uid)
          .collection('records')
          .orderBy('date', descending: true)
          .get();

      final entries = snapshot.docs
          .map((doc) => DonationHistoryEntry.fromFirestore(doc))
          .toList();

      return Right(entries);
    } on FirebaseException catch (e) {
      return Left(
        GeneralFailure(e.message ?? 'Failed to load donation history.'),
      );
    } catch (_) {
      return Left(GeneralFailure('Failed to load donation history.'));
    }
  }

  @override
  Future<Either<Failure, void>> reactivateDonor(String uid) async {
    try {
      final batch = _firestore.batch();
      batch.update(_firestore.collection('profile').doc(uid), {
        'isActive': true,
      });
      batch.update(_firestore.collection('user_locations').doc(uid), {
        'isActive': true,
      });
      await batch.commit();
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(GeneralFailure(e.message ?? 'Failed to reactivate donor.'));
    } catch (_) {
      return Left(GeneralFailure('Failed to reactivate donor.'));
    }
  }

  static String _computeTier(int donations) {
    if (donations >= 25) return 'Platinum';
    if (donations >= 12) return 'Gold';
    if (donations >= 6) return 'Silver';
    if (donations >= 1) return 'Bronze';
    return '';
  }
}
