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
      final recordsRef = _firestore
          .collection('donations')
          .doc(uid)
          .collection('records');

      await _firestore.runTransaction((tx) async {
        final profileSnap = await tx.get(profileRef);
        final currentCount =
            (profileSnap.data()?['totalDonations'] as num?)?.toInt() ?? 0;
        final newCount = currentCount + 1;

        tx.set(recordsRef.doc(), entry.toMap());
        tx.update(profileRef, {
          'totalDonations': newCount,
          'lastDonation': Timestamp.fromDate(entry.date),
          'donorTier': _computeTier(newCount),
        });
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

  static String _computeTier(int donations) {
    if (donations >= 25) return 'Platinum';
    if (donations >= 12) return 'Gold';
    if (donations >= 6) return 'Silver';
    if (donations >= 1) return 'Bronze';
    return '';
  }
}
