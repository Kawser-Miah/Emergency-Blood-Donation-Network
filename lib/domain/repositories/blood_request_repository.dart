import 'package:dartz/dartz.dart';

import '../failures/failures.dart';
import '../models/create_blood_request_params.dart';

abstract class BloodRequestRepository {
  Future<Either<Failure, void>> createRequest(CreateBloodRequestParams params);
}
