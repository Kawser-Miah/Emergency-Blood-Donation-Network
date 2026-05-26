import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileModel {
  final String? userUuid;
  final String? fullName;
  final String? gender;
  final String? email;
  final String? photoUrl;
  final String? phone;
  final String? bloodGroup;
  final String? age;
  final String? lastDonation;
  final String? district;
  final String? thana;
  final String? fbId;
  final double? longitude;
  final double? latitude;
  final DateTime? updatedAt;

  UserProfileModel({
    this.userUuid,
    this.fullName,
    this.gender,
    this.email,
    this.photoUrl,
    this.phone,
    this.bloodGroup,
    this.age,
    this.lastDonation,
    this.district,
    this.thana,
    this.fbId,
    this.longitude,
    this.latitude,
    this.updatedAt,
  });

  /// Fetch from Firestore
  factory UserProfileModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();

    return UserProfileModel(
      userUuid: data?['user_uuid'],
      fullName: data?['fullName'],
      gender: data?['gender'],
      email: data?['email'],
      photoUrl: data?['photoUrl'],
      phone: data?['phone'],
      bloodGroup: data?['bloodGroup'],
      age: data?['age'],
      lastDonation: data?['lastDonation'],
      district: data?['district'],
      thana: data?['thana'],
      fbId: data?['fbId'],
      longitude: data?['longitude'] != null
          ? (data!['longitude'] as num).toDouble()
          : null,
      latitude: data?['latitude'] != null
          ? (data!['latitude'] as num).toDouble()
          : null,
      updatedAt: data?['updatedAt'] != null
          ? (data!['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  /// Convert to Firestore Map
  Map<String, dynamic> toMap() {
    return {
      'user_uuid': userUuid,
      'fullName': fullName,
      'gender': gender,
      'email': email,
      'photoUrl': photoUrl,
      'phone': phone,
      'bloodGroup': bloodGroup,
      'age': age,
      'lastDonation': lastDonation,
      'district': district,
      'thana': thana,
      'fbId': fbId,
      'longitude': longitude,
      'latitude': latitude,
      'updatedAt': updatedAt != null
          ? Timestamp.fromDate(updatedAt!)
          : FieldValue.serverTimestamp(),
    };
  }

  /// CopyWith
  UserProfileModel copyWith({
    String? userUuid,
    String? fullName,
    String? gender,
    String? email,
    String? photoUrl,
    String? phone,
    String? bloodGroup,
    String? age,
    String? lastDonation,
    String? district,
    String? thana,
    String? fbId,
    double? longitude,
    double? latitude,
    DateTime? updatedAt,
  }) {
    return UserProfileModel(
      userUuid: userUuid ?? this.userUuid,
      fullName: fullName ?? this.fullName,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      phone: phone ?? this.phone,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      age: age ?? this.age,
      lastDonation: lastDonation ?? this.lastDonation,
      district: district ?? this.district,
      thana: thana ?? this.thana,
      fbId: fbId ?? this.fbId,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
