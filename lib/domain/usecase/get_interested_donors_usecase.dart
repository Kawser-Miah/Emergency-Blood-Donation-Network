import 'package:blood_setu/domain/models/interested_donor.dart';
import 'package:blood_setu/domain/repositories/blood_request_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../failures/failures.dart';

@injectable
class GetInterestedDonorsUseCase {
  const GetInterestedDonorsUseCase(this._repository);
  final BloodRequestRepository _repository;

  Future<Either<Failure, List<InterestedDonor>>> call(String requestId) =>
      _repository.getInterestedDonors(requestId);
}
