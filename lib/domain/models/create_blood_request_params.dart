import 'package:blood_setu/domain/models/blood_request_enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateBloodRequestParams {
  const CreateBloodRequestParams({
    required this.uid,
    required this.patientName,
    required this.bloodGroup,
    required this.units,
    required this.hospital,
    required this.address,
    required this.urgency,
    required this.needBy,
    required this.contact,
    required this.notes,
    this.latitude,
    this.longitude,
  });

  final String uid;
  final String patientName;
  final String bloodGroup;
  final int units;
  final String hospital;
  final String address;
  final String urgency;
  final DateTime needBy;
  final String contact;
  final String notes;
  final double? latitude;
  final double? longitude;

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'patientName': patientName,
        'bloodGroup': bloodGroup,
        'units': units,
        'hospital': hospital,
        'address': address,
        'urgency': urgency,
        'needBy': Timestamp.fromDate(needBy),
        'contact': contact,
        'notes': notes,
        if (latitude != null) 'latitude': latitude,
        if (longitude != null) 'longitude': longitude,
        'status': RequestStatus.active.value,
        'createdAt': FieldValue.serverTimestamp(),
      };
}
