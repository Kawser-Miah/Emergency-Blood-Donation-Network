import 'package:blood_setu/domain/repositories/blood_request_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../failures/failures.dart';
import '../models/blood_request_enums.dart';

@injectable
class UpdateRequestUseCase {
  const UpdateRequestUseCase(this._repository);
  final BloodRequestRepository _repository;

  Future<Either<Failure, void>> call({
    required String id,
    required String patientName,
    required String contact,
    required String hospital,
    required String address,
    required String urgency,
    required int units,
    required DateTime needBy,
    required String notes,
    double? latitude,
    double? longitude,
  }) {
    final fields = <String, dynamic>{
      'patientName': patientName,
      'contact': contact,
      'hospital': hospital,
      'address': address,
      'urgency': urgency,
      'units': units,
      'needBy': Timestamp.fromDate(needBy),
      'notes': notes,
      'latitude': latitude,
      'longitude': longitude,
    };
    return _repository.updateRequest(id, fields);
  }

  Future<Either<Failure, void>> markFulfilled(String id) =>
      _repository.updateRequest(id, {
        'status': RequestStatus.fulfilled.value,
      });

  Future<Either<Failure, void>> deleteRequest(String id) =>
      _repository.deleteRequest(id);
}
