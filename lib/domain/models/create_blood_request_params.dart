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
}
