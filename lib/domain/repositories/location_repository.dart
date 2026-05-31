import 'package:dartz/dartz.dart';

import '../failures/failures.dart';

abstract class LocationRepository {
  /// Fetches the device's current GPS position and writes ONLY the coordinate
  /// fields (latitude/longitude/geohash) to `user_locations/{uid}`. Called on
  /// app open. Best-effort. The searchable donor fields are written separately
  /// at registration (RegistrationRepository) and profile edit.
  Future<Either<Failure, void>> updateGps(String uid);
}
