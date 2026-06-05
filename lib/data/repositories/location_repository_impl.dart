import 'package:blood_setu/domain/failures/failures.dart';
import 'package:blood_setu/domain/models/donor_location_model.dart';
import 'package:blood_setu/domain/models/location_address_data.dart';
import 'package:blood_setu/domain/repositories/location_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LocationRepository)
class LocationRepositoryImpl extends LocationRepository {
  final FirebaseFirestore _firestore;

  LocationRepositoryImpl(this._firestore);

  @override
  Future<Either<Failure, void>> updateGps(String uid) async {
    try {
      final locationResult = await _fetchCurrentPosition();
      if (locationResult.isLeft()) {
        return locationResult.map((_) {});
      }
      final position = locationResult.getOrElse(() => throw StateError(''));

      // Coordinates only — leaves the searchable donor fields untouched.
      await _firestore
          .collection('user_locations')
          .doc(uid)
          .set(
            DonorLocationModel.coordsMap(position.latitude, position.longitude),
            SetOptions(merge: true),
          );
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(GeneralFailure(e.message ?? 'Failed to update location.'));
    } catch (_) {
      return Left(GeneralFailure('Failed to update location.'));
    }
  }

  @override
  Future<Either<Failure, LocationAddressData>> getAddressData() async {
    try {
      final locationResult = await _fetchCurrentPosition();
      if (locationResult.isLeft()) {
        return locationResult.fold(
          (f) => Left(f),
          (_) => throw StateError(''),
        );
      }
      final position = locationResult.getOrElse(() => throw StateError(''));
      return Right(
        LocationAddressData(
          latitude: position.latitude,
          longitude: position.longitude,
          address: await _reverseGeocode(position.latitude, position.longitude),
        ),
      );
    } on FirebaseException catch (e) {
      return Left(GeneralFailure(e.message ?? 'Failed to get address.'));
    } catch (_) {
      return Left(GeneralFailure('Failed to get address from GPS.'));
    }
  }

  @override
  Future<Either<Failure, LocationAddressData>> getAddressFromCoordinates(
    double lat,
    double lng,
  ) async {
    try {
      return Right(
        LocationAddressData(
          latitude: lat,
          longitude: lng,
          address: await _reverseGeocode(lat, lng),
        ),
      );
    } catch (_) {
      return Left(GeneralFailure('Failed to get address for selected location.'));
    }
  }

  static Future<String> _reverseGeocode(double lat, double lng) async {
    final placemarks = await placemarkFromCoordinates(lat, lng);
    if (placemarks.isEmpty) return '';
    final p = placemarks.first;
    return [p.street, p.subLocality, p.locality, p.administrativeArea]
        .where((s) => s != null && s.isNotEmpty)
        .map((s) => s!)
        .join(', ');
  }

  Future<Either<Failure, Position>> _fetchCurrentPosition() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Left(
          GeneralFailure(
            'Location services are disabled. Please enable GPS and try again.',
          ),
        );
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Left(
            GeneralFailure(
              'Location access was denied. Please grant permission to complete registration.',
            ),
          );
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Left(
          GeneralFailure(
            'Location permission is permanently denied. Please enable it in your device settings.',
          ),
        );
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      return Right(position);
    } catch (e) {
      return Left(
        GeneralFailure(
          'Unable to determine your location. Please check your GPS settings and try again.',
        ),
      );
    }
  }
}
