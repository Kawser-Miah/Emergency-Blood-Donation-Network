import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../failures/failures.dart';
import '../models/nearby_donor.dart';
import '../repositories/nearby_donors_repository.dart';

@injectable
class NearbyDonorsUseCase {
  final NearbyDonorsRepository _repository;

  NearbyDonorsUseCase(this._repository);

  Future<Either<Failure, int>> getTotalDonorCount() =>
      _repository.getTotalDonorCount();

  Future<Either<Failure, ({double latitude, double longitude})>> getOrigin(
    String uid,
  ) => _repository.getOrigin(uid);

  Future<Either<Failure, List<NearbyDonor>>> call({
    required double latitude,
    required double longitude,
    required double radiusKm,
    String? bloodGroup,
    String? excludeUid,
  }) => _repository.getNearbyDonors(
    latitude: latitude,
    longitude: longitude,
    radiusKm: radiusKm,
    bloodGroup: bloodGroup,
    excludeUid: excludeUid,
  );
}
