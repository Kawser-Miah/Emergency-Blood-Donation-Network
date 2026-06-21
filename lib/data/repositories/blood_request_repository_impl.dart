import 'package:blood_setu/data/repositories/repo_guard.dart';
import 'package:blood_setu/domain/failures/failures.dart';
import 'package:blood_setu/domain/models/blood_request.dart';
import 'package:blood_setu/domain/models/blood_request_enums.dart';
import 'package:blood_setu/domain/models/create_blood_request_params.dart';
import 'package:blood_setu/domain/models/interested_donor.dart';
import 'package:blood_setu/domain/models/my_interest_entry.dart';
import 'package:blood_setu/domain/repositories/blood_request_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BloodRequestRepository)
class BloodRequestRepositoryImpl extends BloodRequestRepository {
  final FirebaseFirestore _firestore;

  BloodRequestRepositoryImpl(this._firestore);

  @override
  Future<Either<Failure, void>> createRequest(
    CreateBloodRequestParams params,
  ) => guard(() async {
    await _firestore.collection('blood_requests').add(params.toMap());
    return const Right(null);
  }, fallback: 'Failed to post blood request.');

  @override
  Future<Either<Failure, List<BloodRequest>>> getActiveRequests({
    int limit = 20,
    DateTime? startAfterNeedBy,
    String? excludeUid,
  }) => guard(() async {
    Query<Map<String, dynamic>> query = _firestore
        .collection('blood_requests')
        .where('status', isEqualTo: RequestStatus.active.value)
        .orderBy('needBy', descending: false)
        .limit(limit);

    if (startAfterNeedBy != null) {
      query = query.startAfter([Timestamp.fromDate(startAfterNeedBy)]);
    }

    final snapshot = await query.get();
    var requests = snapshot.docs
        .map((doc) => BloodRequest.fromMap(doc.id, doc.data()))
        .toList();
    if (excludeUid != null) {
      requests = requests.where((r) => r.uid != excludeUid).toList();
    }
    return Right(requests);
  }, fallback: 'Failed to load blood requests.');

  @override
  Future<Either<Failure, List<BloodRequest>>> getMyRequests(String uid) =>
      guard(() async {
        final snapshot = await _firestore
            .collection('blood_requests')
            .where('uid', isEqualTo: uid)
            .orderBy('createdAt', descending: true)
            .get();
        final requests = snapshot.docs
            .map((doc) => BloodRequest.fromMap(doc.id, doc.data()))
            .toList();
        return Right(requests);
      }, fallback: 'Failed to load your requests.');

  @override
  Future<Either<Failure, void>> updateRequest(
    String id,
    Map<String, dynamic> fields,
  ) => guard(() async {
    await _firestore.collection('blood_requests').doc(id).update(fields);
    return const Right(null);
  }, fallback: 'Failed to update request.');

  @override
  Future<Either<Failure, void>> markImComing({
    required String requestId,
    required String donorUid,
    required String donorName,
    required String donorBloodGroup,
    DateTime? lastDonation,
    int totalDonations = 0,
  }) => guard(() async {
    final batch = _firestore.batch();

    batch.set(
      _firestore
          .collection('blood_requests')
          .doc(requestId)
          .collection('interested_donors')
          .doc(donorUid),
      InterestedDonor.toWriteMap(
        name: donorName,
        bloodGroup: donorBloodGroup,
        lastDonation: lastDonation,
        totalDonations: totalDonations,
      ),
    );

    // Denormalized record so the donor can query their own interests.
    batch.set(
      _firestore
          .collection('profile')
          .doc(donorUid)
          .collection('my_interests')
          .doc(requestId),
      {
        'requestId': requestId,
        'bloodGiven': false,
        'timestamp': FieldValue.serverTimestamp(),
      },
    );

    await batch.commit();
    return const Right(null);
  }, fallback: 'Failed to register interest.');

  @override
  Future<Either<Failure, List<InterestedDonor>>> getInterestedDonors(
    String requestId,
  ) => guard(() async {
    final snapshot = await _firestore
        .collection('blood_requests')
        .doc(requestId)
        .collection('interested_donors')
        .orderBy('timestamp', descending: false)
        .get();
    final donors = snapshot.docs
        .map((doc) => InterestedDonor.fromMap(doc.id, doc.data()))
        .toList();
    return Right(donors);
  }, fallback: 'Failed to load interested donors.');

  @override
  Future<Either<Failure, List<MyInterestEntry>>> getMyInterests(
    String donorUid,
  ) => guard(() async {
    final snapshot = await _firestore
        .collection('profile')
        .doc(donorUid)
        .collection('my_interests')
        .orderBy('timestamp', descending: true)
        .get();

    if (snapshot.docs.isEmpty) return const Right([]);

    final reqDocs = await Future.wait(
      snapshot.docs.map(
        (doc) => _firestore.collection('blood_requests').doc(doc.id).get(),
      ),
    );

    final entries = <MyInterestEntry>[];
    for (var i = 0; i < snapshot.docs.length; i++) {
      final bloodGiven =
          snapshot.docs[i].data()['bloodGiven'] as bool? ?? false;
      final reqDoc = reqDocs[i];
      if (reqDoc.exists && reqDoc.data() != null) {
        entries.add(
          MyInterestEntry(
            request: BloodRequest.fromMap(reqDoc.id, reqDoc.data()!),
            bloodGiven: bloodGiven,
          ),
        );
      }
    }
    return Right(entries);
  }, fallback: 'Failed to load your interests.');

  @override
  Future<Either<Failure, void>> withdrawInterest({
    required String requestId,
    required String donorUid,
  }) => guard(() async {
    final batch = _firestore.batch();
    batch.delete(
      _firestore
          .collection('blood_requests')
          .doc(requestId)
          .collection('interested_donors')
          .doc(donorUid),
    );
    batch.delete(
      _firestore
          .collection('profile')
          .doc(donorUid)
          .collection('my_interests')
          .doc(requestId),
    );
    await batch.commit();
    return const Right(null);
  }, fallback: 'Failed to withdraw interest.');

  @override
  Future<Either<Failure, void>> markBloodGiven({
    required String requestId,
    required String donorUid,
  }) => guard(() async {
    await _firestore
        .collection('profile')
        .doc(donorUid)
        .collection('my_interests')
        .doc(requestId)
        .update({'bloodGiven': true});
    return const Right(null);
  }, fallback: 'Failed to record blood donation.');

  @override
  Future<Either<Failure, List<String>>> getMyInterestIds(
    String donorUid,
  ) => guard(() async {
    final snapshot = await _firestore
        .collection('profile')
        .doc(donorUid)
        .collection('my_interests')
        .get();
    return Right(snapshot.docs.map((d) => d.id).toList());
  }, fallback: '');

  @override
  Future<Either<Failure, void>> markExpiredBatch(List<String> ids) =>
      guard(() async {
        if (ids.isEmpty) return const Right(null);
        final batch = _firestore.batch();
        for (final id in ids) {
          batch.update(
            _firestore.collection('blood_requests').doc(id),
            {'status': RequestStatus.expired.value},
          );
        }
        await batch.commit();
        return const Right(null);
      }, fallback: 'Failed to expire requests.');

  @override
  Future<Either<Failure, void>> deleteRequest(String id) => guard(() async {
    final docRef = _firestore.collection('blood_requests').doc(id);

    final subSnap = await docRef.collection('interested_donors').get();
    final batch = _firestore.batch();
    for (final doc in subSnap.docs) {
      batch.delete(doc.reference);
    }
    if (subSnap.docs.isNotEmpty) await batch.commit();

    await docRef.delete();
    return const Right(null);
  }, fallback: 'Failed to delete request.');
}
