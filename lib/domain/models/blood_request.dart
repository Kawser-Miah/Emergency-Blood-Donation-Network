import 'package:blood_setu/domain/models/blood_request_enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'blood_request.freezed.dart';

@freezed
class BloodRequest with _$BloodRequest {
  const factory BloodRequest({
    required String uid,
    required String patientName,
    required String bloodGroup,
    required int units,
    required String hospital,
    required String address,
    required String urgency,
    required DateTime needBy,
    required String contact,
    required String notes,
    double? latitude,
    double? longitude,
    required RequestStatus status,
    CloseReason? closeReason,
    DateTime? createdAt,
  }) = _BloodRequest;

  factory BloodRequest.fromMap(String id, Map<String, dynamic> map) =>
      BloodRequest(
        uid: map['uid'] as String,
        patientName: map['patientName'] as String,
        bloodGroup: map['bloodGroup'] as String,
        units: map['units'] as int,
        hospital: map['hospital'] as String,
        address: map['address'] as String,
        urgency: map['urgency'] as String,
        needBy: (map['needBy'] as Timestamp).toDate(),
        contact: map['contact'] as String,
        notes: (map['notes'] as String?) ?? '',
        latitude: map['latitude'] as double?,
        longitude: map['longitude'] as double?,
        status: RequestStatus.fromString(map['status'] as String? ?? 'active'),
        closeReason: map['closeReason'] != null
            ? CloseReason.fromString(map['closeReason'] as String)
            : null,
        createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
      );
}
