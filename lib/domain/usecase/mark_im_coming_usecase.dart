import 'package:blood_setu/domain/repositories/blood_request_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../failures/failures.dart';

@injectable
class MarkImComingUseCase {
  const MarkImComingUseCase(this._repository);
  final BloodRequestRepository _repository;

  Future<Either<Failure, void>> call({
    required String requestId,
    required String donorUid,
    required String donorName,
    required String donorBloodGroup,
    DateTime? lastDonation,
    int totalDonations = 0,
  }) =>
      _repository.markImComing(
        requestId: requestId,
        donorUid: donorUid,
        donorName: donorName,
        donorBloodGroup: donorBloodGroup,
        lastDonation: lastDonation,
        totalDonations: totalDonations,
      );
}
