import 'package:dartz/dartz.dart';

import '../failures/failures.dart';
import '../models/blood_request.dart';
import '../models/create_blood_request_params.dart';
import '../models/interested_donor.dart';
import '../models/my_interest_entry.dart';

abstract class BloodRequestRepository {
  Future<Either<Failure, void>> createRequest(CreateBloodRequestParams params);

  Future<Either<Failure, List<BloodRequest>>> getActiveRequests({
    int limit = 20,
    DateTime? startAfterNeedBy,
    String? excludeUid,
  });

  Future<Either<Failure, List<BloodRequest>>> getMyRequests(String uid);

  Future<Either<Failure, void>> updateRequest(
    String id,
    Map<String, dynamic> fields,
  );

  Future<Either<Failure, void>> markImComing({
    required String requestId,
    required String donorUid,
    required String donorName,
    required String donorBloodGroup,
    DateTime? lastDonation,
    int totalDonations = 0,
  });

  Future<Either<Failure, List<InterestedDonor>>> getInterestedDonors(
    String requestId,
  );

  Future<Either<Failure, void>> deleteRequest(String id);

  Future<Either<Failure, List<MyInterestEntry>>> getMyInterests(String donorUid);

  Future<Either<Failure, void>> withdrawInterest({
    required String requestId,
    required String donorUid,
  });

  Future<Either<Failure, void>> markBloodGiven({
    required String requestId,
    required String donorUid,
  });
}
