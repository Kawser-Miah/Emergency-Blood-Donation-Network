import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'donor_location_model.dart';

part 'nearby_donor.freezed.dart';

/// A donor surfaced by the nearby search: the persisted [DonorLocationModel]
/// plus the query-time [distanceKm] from the searching user. Distance is NOT
/// stored anywhere — it's contextual to who is searching.
@freezed
class NearbyDonor with _$NearbyDonor {
  const NearbyDonor._();

  const factory NearbyDonor({
    required DonorLocationModel donor,
    required double distanceKm,
  }) = _NearbyDonor;

  /// Build from a `user_locations/{uid}` document. [distanceKm] is the true
  /// great-circle distance from the searching user, computed by the repository.
  factory NearbyDonor.fromLocationDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
    double distanceKm,
  ) => NearbyDonor(
    donor: DonorLocationModel.fromFirestore(doc),
    distanceKm: distanceKm,
  );

  // Delegating getters so the UI reads a donor without reaching into `.donor`.
  String get uid => donor.uid;
  String get name => donor.fullName;
  String get bloodGroup => donor.bloodGroup;
  String get district => donor.district;
  String get thana => donor.thana;
  bool get isActive => donor.isActive;
  int get totalDonations => donor.totalDonations;
  String get donorTier => donor.donorTier;
  String? get photoUrl => donor.photoUrl;
  String? get phone => donor.phone;
  String? get fbId => donor.fbId;
  String get initials => donor.initials;
}
