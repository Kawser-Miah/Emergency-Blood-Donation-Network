import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../failures/failures.dart';
import '../models/create_blood_request_params.dart';
import '../repositories/blood_request_repository.dart';

@injectable
class CreateRequestUseCase {
  final BloodRequestRepository _bloodRequestRepository;

  CreateRequestUseCase(this._bloodRequestRepository);

  Future<Either<Failure, void>> execute(CreateBloodRequestParams params) =>
      _bloodRequestRepository.createRequest(params);
}
