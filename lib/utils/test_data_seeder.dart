import 'dart:math';

import 'package:blood_setu/application/core/constants/bangladesh_locations.dart';
import 'package:blood_setu/utils/geohash_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Seeds mock donor data for testing.
class TestDataSeeder {
  static final _firestore = FirebaseFirestore.instance;

  // Cox's Bazar Sadar — used as spoofed origin for the searching user.
  static const double _originLat = 21.4272;
  static const double _originLng = 92.0058;

  // ── District centre coordinates (lat, lng) ──────────────────────────────
  static const Map<String, (double, double)> _districtCenters = {
    // Barishal Division
    'Barguna':       (22.0167, 90.1167),
    'Barishal':      (22.7010, 90.3535),
    'Bhola':         (22.6855, 90.6478),
    'Jhalokati':     (22.6400, 90.2042),
    'Patuakhali':    (22.3596, 90.3298),
    'Pirojpur':      (22.5793, 89.9758),
    // Chattogram Division
    'Bandarban':     (22.1953, 92.2184),
    'Brahmanbaria':  (23.9608, 91.1115),
    'Chandpur':      (23.2300, 90.6718),
    'Chattogram':    (22.3569, 91.7832),
    'Cumilla':       (23.4607, 91.1809),
    "Cox's Bazar":   (21.4272, 92.0058),
    'Feni':          (23.0238, 91.3960),
    'Khagrachhari':  (23.1193, 91.9847),
    'Lakshmipur':    (22.9425, 90.8381),
    'Noakhali':      (22.8696, 91.0996),
    'Rangamati':     (22.6406, 92.2094),
    // Dhaka Division
    'Dhaka':         (23.8103, 90.4125),
    'Faridpur':      (23.6070, 89.8424),
    'Gazipur':       (24.0022, 90.4263),
    'Gopalganj':     (23.0053, 89.8263),
    'Kishoreganj':   (24.1845, 90.9767),
    'Madaripur':     (23.1639, 90.1981),
    'Manikganj':     (23.8637, 89.9998),
    'Munshiganj':    (23.5422, 90.5335),
    'Narayanganj':   (23.6238, 90.4997),
    'Narsingdi':     (23.9217, 90.7150),
    'Rajbari':       (23.7572, 89.6441),
    'Shariatpur':    (23.2423, 90.4347),
    'Tangail':       (24.2512, 89.9167),
    // Khulna Division
    'Bagerhat':      (22.6602, 89.7854),
    'Chuadanga':     (23.6401, 88.8433),
    'Jashore':       (23.1667, 89.2167),
    'Jhenaidah':     (23.5448, 89.1531),
    'Khulna':        (22.8456, 89.5403),
    'Kushtia':       (23.9011, 89.1203),
    'Magura':        (23.4893, 89.4198),
    'Meherpur':      (23.7621, 88.6318),
    'Narail':        (23.1730, 89.5123),
    'Satkhira':      (22.7185, 89.0705),
    // Mymensingh Division
    'Jamalpur':      (24.8979, 89.9478),
    'Mymensingh':    (24.7471, 90.4203),
    'Netrokona':     (24.8843, 90.8710),
    'Sherpur':       (25.0190, 90.0170),
    // Rajshahi Division
    'Bogura':        (24.8465, 89.3773),
    'Joypurhat':     (25.1000, 89.0333),
    'Naogaon':       (24.8133, 88.9311),
    'Natore':        (24.4200, 88.9873),
    'Nawabganj':     (24.5964, 88.2777),
    'Pabna':         (24.0063, 89.2372),
    'Rajshahi':      (24.3745, 88.6042),
    'Sirajganj':     (24.4508, 89.7003),
    // Rangpur Division
    'Dinajpur':      (25.6279, 88.6331),
    'Gaibandha':     (25.3284, 89.5427),
    'Kurigram':      (25.8062, 89.6358),
    'Lalmonirhat':   (25.9923, 89.2847),
    'Nilphamari':    (25.9310, 88.8562),
    'Panchagarh':    (26.3410, 88.5551),
    'Rangpur':       (25.7439, 89.2752),
    'Thakurgaon':    (26.0425, 88.4514),
    // Sylhet Division
    'Habiganj':      (24.3745, 91.4153),
    'Moulvibazar':   (24.4826, 91.7775),
    'Sunamganj':     (25.0659, 91.3950),
    'Sylhet':        (24.8998, 91.8687),
  };

  static const List<String> _maleNames = [
    'Mohammad', 'Abdul', 'Md', 'Rahim', 'Karim', 'Jamal', 'Rifat', 'Sumon',
    'Rubel', 'Raju', 'Arif', 'Sohel', 'Ripon', 'Nasim', 'Imran', 'Alamin',
    'Mahbub', 'Rasel', 'Tanim', 'Rakib', 'Shohel', 'Jahid', 'Nazmul', 'Rony',
    'Sabbir', 'Taufiq', 'Wahid', 'Yeasin', 'Zakir', 'Belal',
  ];

  static const List<String> _femaleNames = [
    'Fatema', 'Nasrin', 'Sadia', 'Ayesha', 'Rina', 'Tania', 'Mitu', 'Monika',
    'Rupa', 'Shirin', 'Meher', 'Parveen', 'Ruma', 'Lipi', 'Rehana', 'Suma',
    'Nipa', 'Jui', 'Moni', 'Poly', 'Sharmin', 'Roksana', 'Taslima', 'Munni',
    'Laila', 'Kohinoor', 'Jhuma', 'Asha', 'Puja', 'Maliha',
  ];

  static const List<String> _lastNames = [
    'Hossain', 'Ahmed', 'Khan', 'Islam', 'Rahman', 'Begum', 'Akter', 'Sultana',
    'Mia', 'Ali', 'Uddin', 'Ullah', 'Hasan', 'Molla', 'Sheikh', 'Biswas',
    'Das', 'Roy', 'Chowdhury', 'Sarkar', 'Paul', 'Mondal', 'Talukder', 'Bhuiyan',
  ];

  static const List<String> _bloodGroups = [
    'O+', 'A+', 'B+', 'AB+', 'O-', 'A-', 'B-', 'AB-',
  ];

  // ── Public API ────────────────────────────────────────────────────────────

  /// Inserts 8 Cox's Bazar mock donors. Safe to call multiple times.
  static Future<void> seedCoxsBazarDonors() async {
    final batch = _firestore.batch();
    for (final donor in _coxsBazarDonors) {
      final uid = donor['uid'] as String;
      final ref = _firestore.collection('user_locations').doc(uid);
      final data = Map<String, dynamic>.from(donor)..remove('uid');
      batch.set(ref, data, SetOptions(merge: true));
    }
    await batch.commit();
  }

  /// Inserts 1000+ donors spread across every thana in Bangladesh.
  /// Writes in batches of 400 (Firestore limit is 500 per batch).
  static Future<void> seedAllBangladeshDonors() async {
    final donors = _generateAllDonors();
    for (int i = 0; i < donors.length; i += 400) {
      final batch = _firestore.batch();
      final chunk = donors.sublist(i, min(i + 400, donors.length));
      for (final donor in chunk) {
        final uid = donor['uid'] as String;
        final ref = _firestore.collection('user_locations').doc(uid);
        final data = Map<String, dynamic>.from(donor)..remove('uid');
        batch.set(ref, data, SetOptions(merge: true));
      }
      await batch.commit();
    }
  }

  /// Sets the signed-in user's location to Cox's Bazar Sadar so that
  /// getOrigin() returns a valid origin near the Cox's Bazar mock donors.
  static Future<void> spoofUserLocationToCoxsBazar(String uid) async {
    await _firestore.collection('user_locations').doc(uid).set(
      {
        'latitude': _originLat,
        'longitude': _originLng,
        'geohash': GeohashUtil.encode(_originLat, _originLng),
        'locationUpdatedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }

  /// Seeds all Bangladesh donors AND spoofs the current user's location.
  static Future<void> seedAll() async {
    await Future.wait([
      seedCoxsBazarDonors(),
      seedAllBangladeshDonors(),
    ]);
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await spoofUserLocationToCoxsBazar(uid);
    }
  }

  // ── Generation ────────────────────────────────────────────────────────────

  static List<Map<String, dynamic>> _generateAllDonors() {
    final donors = <Map<String, dynamic>>[];
    int idx = 0;

    for (final district in bangladeshDistricts) {
      final thanas = thanasByDistrict[district] ?? [];
      final center = _districtCenters[district];
      if (center == null) continue;

      final (distLat, distLng) = center;
      final n = thanas.length;

      for (int i = 0; i < n; i++) {
        final thana = thanas[i];

        // Spread thanas in a 3-column grid around the district centre.
        final row = i ~/ 3;
        final col = i % 3;
        final baseLat = distLat + (row - (n ~/ 6)) * 0.08;
        final baseLng = distLng + (col - 1) * 0.08;

        // 3 donors per thana.
        for (int d = 0; d < 3; d++) {
          final isMale = d != 1;
          final lat = baseLat + d * 0.004;
          final lng = baseLng + d * 0.004;
          final donations = (idx * 7 + 3) % 28;

          donors.add({
            'uid': 'test_bd_${idx.toString().padLeft(4, '0')}',
            'fullName': _name(idx, isMale),
            'bloodGroup': _bloodGroups[idx % 8],
            'district': district,
            'thana': thana,
            'isActive': idx % 5 != 0,
            'donorTier': _tier(donations),
            'totalDonations': donations,
            'photoUrl': null,
            'infoUpdatedAt': FieldValue.serverTimestamp(),
            'latitude': lat,
            'longitude': lng,
            'geohash': GeohashUtil.encode(lat, lng),
            'locationUpdatedAt': FieldValue.serverTimestamp(),
          });
          idx++;
        }
      }
    }
    return donors;
  }

  static String _name(int idx, bool male) {
    final first = male
        ? _maleNames[idx % _maleNames.length]
        : _femaleNames[idx % _femaleNames.length];
    final last = _lastNames[idx % _lastNames.length];
    return '$first $last';
  }

  static String _tier(int donations) {
    if (donations == 0) return '';
    if (donations <= 5) return 'Bronze';
    if (donations <= 11) return 'Silver';
    if (donations <= 24) return 'Gold';
    return 'Platinum';
  }

  // ── Cox's Bazar static donors ─────────────────────────────────────────────

  static final List<Map<String, dynamic>> _coxsBazarDonors = [
    _cxbDonor('test_cxb_001', 'Karim Ullah',    'O+',  "Cox's Bazar Sadar", 21.4272, 92.0058, 8,  'Silver'),
    _cxbDonor('test_cxb_002', 'Fatema Begum',   'A+',  "Cox's Bazar Sadar", 21.4310, 92.0102, 3,  'Bronze'),
    _cxbDonor('test_cxb_003', 'Rahmat Ali',     'B+',  'Ramu',              21.4524, 92.1159, 15, 'Gold'),
    _cxbDonor('test_cxb_004', 'Nasrin Sultana', 'AB+', 'Ukhia',             21.2112, 92.1252, 1,  'Bronze', isActive: false),
    _cxbDonor('test_cxb_005', 'Jamal Hossain',  'O-',  "Cox's Bazar Sadar", 21.4350, 91.9980, 27, 'Platinum'),
    _cxbDonor('test_cxb_006', 'Sadia Islam',    'A-',  'Chakaria',          21.7278, 92.0741, 5,  'Bronze'),
    _cxbDonor('test_cxb_007', 'Mohammod Rifat', 'B-',  "Cox's Bazar Sadar", 21.4200, 92.0200, 12, 'Gold'),
    _cxbDonor('test_cxb_008', 'Ayesha Khanam',  'AB-', 'Teknaf',            20.8628, 92.3010, 0,  ''),
  ];

  static Map<String, dynamic> _cxbDonor(
    String uid, String fullName, String bloodGroup, String thana,
    double lat, double lng, int totalDonations, String donorTier, {
    bool isActive = true,
  }) => {
    'uid': uid,
    'fullName': fullName,
    'bloodGroup': bloodGroup,
    'district': "Cox's Bazar",
    'thana': thana,
    'isActive': isActive,
    'donorTier': donorTier,
    'totalDonations': totalDonations,
    'photoUrl': null,
    'infoUpdatedAt': FieldValue.serverTimestamp(),
    'latitude': lat,
    'longitude': lng,
    'geohash': GeohashUtil.encode(lat, lng),
    'locationUpdatedAt': FieldValue.serverTimestamp(),
  };
}
