import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../failures/failures.dart';
import '../repositories/location_repository.dart';

@injectable
class LocationUseCase {
  final LocationRepository _locationRepository;

  LocationUseCase(this._locationRepository);

  Future<Either<Failure, void>> updateLocation(String uid) =>
      _locationRepository.updateLocation(uid);
}
