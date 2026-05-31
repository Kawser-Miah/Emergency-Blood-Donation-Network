import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../failures/failures.dart';
import '../repositories/location_repository.dart';

@injectable
class LocationUseCase {
  final LocationRepository _locationRepository;

  LocationUseCase(this._locationRepository);

  /// Refresh GPS coordinates only (app open).
  Future<Either<Failure, void>> updateGps(String uid) =>
      _locationRepository.updateGps(uid);
}
