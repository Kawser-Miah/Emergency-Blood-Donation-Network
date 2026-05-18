import 'package:freezed_annotation/freezed_annotation.dart';

part 'blood_request.freezed.dart';

@freezed
class BloodRequest with _$BloodRequest {
  const factory BloodRequest({
    required String id,
    required String urgency,
    required String bloodGroup,
    required String hospital,
    required double distance,
    required int unitsNeeded,
    required int respondents,
    required String timePosted,
    required String patientName,
  }) = _BloodRequest;
}
