import 'package:blood_setu/domain/failures/failures.dart';
import 'package:blood_setu/domain/repositories/registration_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../models/user_profile_model.dart';

@injectable
class RegistrationUserUseCase {
  final RegistrationRepository _registrationRepository;
  RegistrationUserUseCase(this._registrationRepository);

  Future<Either<Failure, void>> call(UserProfileModel userProfile) async =>
      await _registrationRepository.register(userProfile);
}
