import 'package:blood_setu/domain/models/blood_request.dart';
import 'package:blood_setu/domain/repositories/blood_request_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../failures/failures.dart';

@injectable
class MyRequestsUseCase {
  const MyRequestsUseCase(this._repository);
  final BloodRequestRepository _repository;

  Future<Either<Failure, List<BloodRequest>>> call(String uid) =>
      _repository.getMyRequests(uid);
}
