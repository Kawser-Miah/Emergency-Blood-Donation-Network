import 'package:blood_setu/domain/models/blood_request.dart';

class MyInterestEntry {
  const MyInterestEntry({required this.request, required this.bloodGiven});

  final BloodRequest request;
  final bool bloodGiven;

  MyInterestEntry copyWith({BloodRequest? request, bool? bloodGiven}) =>
      MyInterestEntry(
        request: request ?? this.request,
        bloodGiven: bloodGiven ?? this.bloodGiven,
      );
}
