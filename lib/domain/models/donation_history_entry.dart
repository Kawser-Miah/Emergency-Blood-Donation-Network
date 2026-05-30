import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'donation_history_entry.freezed.dart';

@freezed
class DonationHistoryEntry with _$DonationHistoryEntry {
  const DonationHistoryEntry._();

  const factory DonationHistoryEntry({
    required String id,
    required DateTime date,
    required String hospital,
    required String bloodGroup,
    required String status,
    DateTime? createdAt,
  }) = _DonationHistoryEntry;

  factory DonationHistoryEntry.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return DonationHistoryEntry(
      id: doc.id,
      date: (data['date'] as Timestamp).toDate(),
      hospital: data['hospital'] as String? ?? '',
      bloodGroup: data['bloodGroup'] as String? ?? '',
      status: data['status'] as String? ?? 'Confirmed',
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() => {
    'date': Timestamp.fromDate(date),
    'hospital': hospital,
    'bloodGroup': bloodGroup,
    'status': status,
    'createdAt': createdAt != null
        ? Timestamp.fromDate(createdAt!)
        : FieldValue.serverTimestamp(),
  };
}
