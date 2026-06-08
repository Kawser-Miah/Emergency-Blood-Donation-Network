import 'package:blood_setu/domain/failures/failures.dart';
import 'package:blood_setu/domain/repositories/donation_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReactivateDonorUseCase {
  final DonationRepository _donationRepository;

  ReactivateDonorUseCase(this._donationRepository);

  Future<Either<Failure, void>> call(String uid) =>
      _donationRepository.reactivateDonor(uid);
}
