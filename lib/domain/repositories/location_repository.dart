import 'package:dartz/dartz.dart';

import '../failures/failures.dart';
import '../models/location_address_data.dart';

abstract class LocationRepository {
  /// Fetches the device's current GPS position and writes ONLY the coordinate
  /// fields (latitude/longitude/geohash) to `user_locations/{uid}`. Called on
  /// app open. Best-effort. The searchable donor fields are written separately
  /// at registration (RegistrationRepository) and profile edit.
  Future<Either<Failure, void>> updateGps(String uid);

  /// Gets the current GPS position and reverse-geocodes it into a human-readable
  /// address. Used when the user taps "Use my GPS location" on a form.
  Future<Either<Failure, LocationAddressData>> getAddressData();
}
