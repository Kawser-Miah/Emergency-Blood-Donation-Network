import 'package:dartz/dartz.dart';

import '../failures/failures.dart';

abstract class LocationRepository {
  Future<Either<Failure, void>> updateLocation(String uid);
}
