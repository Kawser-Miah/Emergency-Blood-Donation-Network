import 'package:blood_setu/domain/models/donation_history_entry.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../failures/failures.dart';
import '../repositories/donation_repository.dart';

@injectable
class DonationUseCase {
  final DonationRepository _donationRepository;

  DonationUseCase(this._donationRepository);

  Future<Either<Failure, void>> addDonation(
    String uid,
    DonationHistoryEntry entry,
  ) => _donationRepository.addDonation(uid, entry);

  Future<Either<Failure, List<DonationHistoryEntry>>> getDonationHistory(
    String uid,
  ) => _donationRepository.getDonationHistory(uid);
}
