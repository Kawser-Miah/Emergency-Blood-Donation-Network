import 'dart:math' as math;

import 'package:geolocator/geolocator.dart';

import 'geohash_util.dart';

/// A contiguous `[start, end]` geohash interval to feed into a Firestore
/// `orderBy('geohash').startAt([start]).endAt([end])` query.
class GeohashRange {
  final String start;
  final String end;

  const GeohashRange(this.start, this.end);
}

/// Helpers for geohash proximity (bounding-box) queries against Firestore.
///
/// Ported from the canonical `geofire-common` `geohashQueryBounds` algorithm.
/// A single Firestore query can only range over ONE contiguous geohash
/// interval, so a circular search area is covered by up to 9 ranges (the
/// centre cell plus its 8 neighbours). Run one query per range, merge the
/// results, then filter/sort by the true [distanceKm].
class GeoQueryUtil {
  static const int _bitsPerChar = 5;
  static const int _maxBitsPrecision = 22 * _bitsPerChar;
  static const String _base32 = '0123456789bcdefghjkmnpqrstuvwxyz';

  // WGS84 constants.
  static const double _metersPerDegreeLatitude = 110574;
  static const double _earthMeridionalCircumference = 40007860;
  static const double _earthEqRadius = 6378137.0;
  static const double _earthE2 = 0.00669447819799;
  static const double _epsilon = 1e-12;

  static double _deg2rad(double deg) => deg * math.pi / 180.0;
  static double _log2(double x) => math.log(x) / math.ln2;

  static double _metersToLongitudeDegrees(double distance, double latitude) {
    final radians = _deg2rad(latitude);
    final numerator = math.cos(radians) * _earthEqRadius * math.pi / 180.0;
    final denom =
        1 / math.sqrt(1 - _earthE2 * math.sin(radians) * math.sin(radians));
    final deltaDeg = numerator * denom;
    if (deltaDeg < _epsilon) {
      return distance > 0 ? 360.0 : 0.0;
    }
    return math.min(360.0, distance / deltaDeg);
  }

  static double _longitudeBitsForResolution(double resolution, double latitude) {
    final degs = _metersToLongitudeDegrees(resolution, latitude);
    return (degs.abs() > 0.000001) ? math.max(1.0, _log2(360.0 / degs)) : 1.0;
  }

  static double _latitudeBitsForResolution(double resolution) {
    return math.min(
      _log2(_earthMeridionalCircumference / 2 / resolution),
      _maxBitsPrecision.toDouble(),
    );
  }

  static double _wrapLongitude(double longitude) {
    if (longitude <= 180 && longitude >= -180) return longitude;
    final adjusted = longitude + 180;
    if (adjusted > 0) {
      return (adjusted % 360) - 180;
    }
    return 180 - (-adjusted % 360);
  }

  static int _boundingBoxBits(double latitude, double size) {
    final latDeltaDegrees = size / _metersPerDegreeLatitude;
    final latitudeNorth = math.min(90.0, latitude + latDeltaDegrees);
    final latitudeSouth = math.max(-90.0, latitude - latDeltaDegrees);
    final bitsLat = _latitudeBitsForResolution(size).floor() * 2;
    final bitsLongNorth =
        _longitudeBitsForResolution(size, latitudeNorth).floor() * 2 - 1;
    final bitsLongSouth =
        _longitudeBitsForResolution(size, latitudeSouth).floor() * 2 - 1;
    return [bitsLat, bitsLongNorth, bitsLongSouth, _maxBitsPrecision]
        .reduce(math.min);
  }

  static List<List<double>> _boundingBoxCoordinates(
    double latitude,
    double longitude,
    double size,
  ) {
    final latDegrees = size / _metersPerDegreeLatitude;
    final latitudeNorth = math.min(90.0, latitude + latDegrees);
    final latitudeSouth = math.max(-90.0, latitude - latDegrees);
    final longDegsNorth = _metersToLongitudeDegrees(size, latitudeNorth);
    final longDegsSouth = _metersToLongitudeDegrees(size, latitudeSouth);
    final longDegs = math.max(longDegsNorth, longDegsSouth);
    return [
      [latitude, longitude],
      [latitude, _wrapLongitude(longitude - longDegs)],
      [latitude, _wrapLongitude(longitude + longDegs)],
      [latitudeNorth, longitude],
      [latitudeNorth, _wrapLongitude(longitude - longDegs)],
      [latitudeNorth, _wrapLongitude(longitude + longDegs)],
      [latitudeSouth, longitude],
      [latitudeSouth, _wrapLongitude(longitude - longDegs)],
      [latitudeSouth, _wrapLongitude(longitude + longDegs)],
    ];
  }

  static GeohashRange _geohashQuery(String geohash, int bits) {
    final precision = (bits / _bitsPerChar).ceil();
    if (geohash.length < precision) {
      return GeohashRange(geohash, '$geohash~');
    }
    geohash = geohash.substring(0, precision);
    final base = geohash.substring(0, geohash.length - 1);
    final lastValue = _base32.indexOf(geohash[geohash.length - 1]);
    final significantBits = bits - base.length * _bitsPerChar;
    final unusedBits = _bitsPerChar - significantBits;
    final startValue = (lastValue >> unusedBits) << unusedBits;
    final endValue = startValue + (1 << unusedBits);
    if (endValue > 31) {
      return GeohashRange('$base${_base32[startValue]}', '$base~');
    }
    return GeohashRange(
      '$base${_base32[startValue]}',
      '$base${_base32[endValue]}',
    );
  }

  /// Returns the set of geohash ranges that cover a circle of [radiusMeters]
  /// around ([latitude], [longitude]). Feed each range to a separate Firestore
  /// query and merge the results.
  static List<GeohashRange> queryBounds(
    double latitude,
    double longitude,
    double radiusMeters,
  ) {
    final queryBits = math.max(1, _boundingBoxBits(latitude, radiusMeters));
    final geohashPrecision = (queryBits / _bitsPerChar).ceil();
    final coordinates =
        _boundingBoxCoordinates(latitude, longitude, radiusMeters);

    final ranges = coordinates.map((c) {
      final hash = GeohashUtil.encode(c[0], c[1], precision: geohashPrecision);
      return _geohashQuery(hash, queryBits);
    });

    // Dedupe identical ranges produced by overlapping neighbour cells.
    final seen = <String>{};
    final unique = <GeohashRange>[];
    for (final r in ranges) {
      if (seen.add('${r.start}|${r.end}')) unique.add(r);
    }
    return unique;
  }

  /// Great-circle distance in kilometres between two points.
  static double distanceKm(
    double lat1,
    double lng1,
    double lat2,
    double lng2,
  ) {
    return Geolocator.distanceBetween(lat1, lng1, lat2, lng2) / 1000.0;
  }
}
