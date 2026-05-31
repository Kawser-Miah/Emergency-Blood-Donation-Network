import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/geohash_util.dart';

part 'donor_location_model.freezed.dart';

/// The `user_locations/{uid}` document — the searchable donor index.
///
/// This is its OWN entity, not a copy of [UserProfileModel]. Its two groups of
/// fields are written by two independent paths (both `merge: true`, so neither
/// clobbers the other):
///   * searchable info (name/bloodGroup/district/…) — written at registration
///     and profile edit, via [toInfoMap]. Changes rarely.
///   * coordinates (lat/lng/geohash) — written on app open from GPS, via
///     [coordsMap]. Changes often.
@freezed
class DonorLocationModel with _$DonorLocationModel {
  const DonorLocationModel._();

  const factory DonorLocationModel({
    required String uid,
    @Default('') String fullName,
    @Default('') String bloodGroup,
    @Default('') String district,
    @Default('') String thana,
    @Default(true) bool isActive,
    @Default('') String donorTier,
    @Default(0) int totalDonations,
    String? photoUrl,
    double? latitude,
    double? longitude,
    String? geohash,
  }) = _DonorLocationModel;

  factory DonorLocationModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? const <String, dynamic>{};
    return DonorLocationModel(
      uid: doc.id,
      fullName: (data['fullName'] as String?) ?? '',
      bloodGroup: (data['bloodGroup'] as String?) ?? '',
      district: (data['district'] as String?) ?? '',
      thana: (data['thana'] as String?) ?? '',
      isActive: (data['isActive'] as bool?) ?? true,
      donorTier: (data['donorTier'] as String?) ?? '',
      totalDonations: (data['totalDonations'] as num?)?.toInt() ?? 0,
      photoUrl: data['photoUrl'] as String?,
      latitude: (data['latitude'] as num?)?.toDouble(),
      longitude: (data['longitude'] as num?)?.toDouble(),
      geohash: data['geohash'] as String?,
    );
  }

  /// Searchable donor fields only — written at registration / profile edit.
  /// Never includes coordinates, so it can't overwrite a fresher GPS write.
  Map<String, dynamic> toInfoMap() => {
    'fullName': fullName,
    'bloodGroup': bloodGroup,
    'district': district,
    'thana': thana,
    'isActive': isActive,
    'donorTier': donorTier,
    'totalDonations': totalDonations,
    'photoUrl': photoUrl,
    'infoUpdatedAt': FieldValue.serverTimestamp(),
  };

  /// GPS fields only — written on app open. Computes the geohash from coords.
  static Map<String, dynamic> coordsMap(double latitude, double longitude) => {
    'latitude': latitude,
    'longitude': longitude,
    'geohash': GeohashUtil.encode(latitude, longitude),
    'locationUpdatedAt': FieldValue.serverTimestamp(),
  };

  /// Two-letter initials for the avatar fallback.
  String get initials {
    final parts = fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }
}
