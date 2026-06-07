import 'package:blood_setu/domain/models/blood_request.dart';
import 'package:blood_setu/domain/repositories/blood_request_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../failures/failures.dart';

@injectable
class BloodRequestsUseCase {
  final BloodRequestRepository _repository;

  BloodRequestsUseCase(this._repository);

  Future<Either<Failure, List<BloodRequest>>> call({
    int limit = 20,
    DateTime? startAfterNeedBy,
    String? excludeUid,
  }) => _repository.getActiveRequests(
        limit: limit,
        startAfterNeedBy: startAfterNeedBy,
        excludeUid: excludeUid,
      );
}
