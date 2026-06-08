import 'package:blood_setu/domain/models/my_interest_entry.dart';
import 'package:blood_setu/domain/repositories/blood_request_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../failures/failures.dart';

@injectable
class GetMyInterestsUseCase {
  const GetMyInterestsUseCase(this._repository);
  final BloodRequestRepository _repository;

  Future<Either<Failure, List<MyInterestEntry>>> call(String donorUid) =>
      _repository.getMyInterests(donorUid);
}
