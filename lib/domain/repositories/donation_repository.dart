import 'package:blood_setu/domain/models/donation_history_entry.dart';
import 'package:dartz/dartz.dart';

import '../failures/failures.dart';

abstract class DonationRepository {
  Future<Either<Failure, void>> addDonation(
    String uid,
    DonationHistoryEntry entry,
  );

  Future<Either<Failure, List<DonationHistoryEntry>>> getDonationHistory(
    String uid,
  );
}
