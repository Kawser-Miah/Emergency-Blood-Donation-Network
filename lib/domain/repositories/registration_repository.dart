import 'package:blood_setu/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

import '../models/user_profile_model.dart';

abstract class RegistrationRepository {
  Future<Either<Failure, void>> register(UserProfileModel userProfile);
}