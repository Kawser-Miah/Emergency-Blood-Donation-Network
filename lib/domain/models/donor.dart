import 'package:freezed_annotation/freezed_annotation.dart';

part 'donor.freezed.dart';

@freezed
class Donor with _$Donor {
  const factory Donor({
    required String id,
    required String name,
    required String bloodGroup,
    required String district,
    required String thana,
    required double distance,
    required double rating,
    required int reviews,
    required int donations,
    required String lastDonation,
    required String status,
    required bool online,
    required String initials,
    required String avatarColor,
  }) = _Donor;
}
