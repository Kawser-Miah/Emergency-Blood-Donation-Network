import 'package:blood_setu/domain/failures/failures.dart';
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
}
