import 'package:blood_setu/domain/repositories/blood_request_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../failures/failures.dart';

@injectable
class WithdrawInterestUseCase {
  const WithdrawInterestUseCase(this._repository);
  final BloodRequestRepository _repository;

  Future<Either<Failure, void>> call({
    required String requestId,
    required String donorUid,
  }) =>
      _repository.withdrawInterest(requestId: requestId, donorUid: donorUid);
}
