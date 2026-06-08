import 'package:blood_setu/domain/failures/failures.dart';
import 'package:blood_setu/domain/repositories/blood_request_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMyInterestIdsUseCase {
  final BloodRequestRepository _repo;
  GetMyInterestIdsUseCase(this._repo);

  Future<Either<Failure, List<String>>> call(String donorUid) =>
      _repo.getMyInterestIds(donorUid);
}
