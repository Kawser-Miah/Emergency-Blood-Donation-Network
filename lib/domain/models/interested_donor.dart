import 'package:cloud_firestore/cloud_firestore.dart';

class InterestedDonor {
  const InterestedDonor({
    required this.uid,
    required this.name,
    required this.bloodGroup,
    required this.timestamp,
    this.lastDonation,
    this.totalDonations = 0,
  });

  final String uid;
  final String name;
  final String bloodGroup;
  final DateTime timestamp;
  final DateTime? lastDonation;
  final int totalDonations;

  factory InterestedDonor.fromMap(String uid, Map<String, dynamic> map) =>
      InterestedDonor(
        uid: uid,
        name: map['name'] as String? ?? '',
        bloodGroup: map['bloodGroup'] as String? ?? '',
        timestamp: (map['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
        lastDonation: (map['lastDonation'] as Timestamp?)?.toDate(),
        totalDonations: (map['totalDonations'] as num?)?.toInt() ?? 0,
      );

  static Map<String, dynamic> toWriteMap({
    required String name,
    required String bloodGroup,
    DateTime? lastDonation,
    int totalDonations = 0,
  }) =>
      {
        'name': name,
        'bloodGroup': bloodGroup,
        if (lastDonation != null)
          'lastDonation': Timestamp.fromDate(lastDonation),
        'totalDonations': totalDonations,
        'timestamp': FieldValue.serverTimestamp(),
      };
}
