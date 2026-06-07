import 'package:blood_setu/domain/failures/failures.dart';
import 'package:blood_setu/domain/models/blood_request.dart';
import 'package:blood_setu/domain/models/blood_request_enums.dart';
import 'package:blood_setu/domain/models/create_blood_request_params.dart';
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
  ) async {
    try {
      await _firestore.collection('blood_requests').add(params.toMap());
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(GeneralFailure(e.message ?? 'Failed to post blood request.'));
    } catch (_) {
      return Left(GeneralFailure('Failed to post blood request.'));
    }
  }

  @override
  Future<Either<Failure, List<BloodRequest>>> getActiveRequests({
    int limit = 20,
    DateTime? startAfterNeedBy,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _firestore
          .collection('blood_requests')
          .where('status', isEqualTo: RequestStatus.active.value)
          .orderBy('needBy', descending: false)
          .limit(limit);

      if (startAfterNeedBy != null) {
        query = query.startAfter([Timestamp.fromDate(startAfterNeedBy)]);
      }

      final snapshot = await query.get();
      final requests = snapshot.docs
          .map((doc) => BloodRequest.fromMap(doc.id, doc.data()))
          .toList();
      return Right(requests);
    } on FirebaseException catch (e) {
      return Left(
        GeneralFailure(e.message ?? 'Failed to load blood requests.'),
      );
    } catch (_) {
      return Left(GeneralFailure('Failed to load blood requests.'));
    }
  }
}
