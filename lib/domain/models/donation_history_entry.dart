import 'package:freezed_annotation/freezed_annotation.dart';

part 'donation_history_entry.freezed.dart';

@freezed
class DonationHistoryEntry with _$DonationHistoryEntry {
  const factory DonationHistoryEntry({
    required String id,
    required String date,
    required String hospital,
    required String bloodGroup,
    required String status,
  }) = _DonationHistoryEntry;
}
