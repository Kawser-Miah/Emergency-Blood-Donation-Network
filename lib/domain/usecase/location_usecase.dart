import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../failures/failures.dart';
import '../models/location_address_data.dart';
import '../repositories/location_repository.dart';

@injectable
class LocationUseCase {
  final LocationRepository _locationRepository;

  LocationUseCase(this._locationRepository);

  /// Refresh GPS coordinates only (app open).
  Future<Either<Failure, void>> updateGps(String uid) =>
      _locationRepository.updateGps(uid);

  /// Get current GPS position and reverse-geocode to a full address.
  Future<Either<Failure, LocationAddressData>> getAddressData() =>
      _locationRepository.getAddressData();

  /// Reverse-geocode a known coordinate pair to a full address.
  Future<Either<Failure, LocationAddressData>> getAddressFromCoordinates(
    double lat,
    double lng,
  ) => _locationRepository.getAddressFromCoordinates(lat, lng);
}
