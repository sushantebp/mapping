import 'dart:math' as math;

class GeoHelper {
  static Map<String, double> getBoundingBox({
    required double lat,
    required double lon,
    double radiusInKm = 5.0,
  }) {
    const kmPerDegree = 111.0;

    final latDelta = radiusInKm / kmPerDegree;
    final lonDelta = radiusInKm / (kmPerDegree * math.cos(lat * math.pi / 180));

    return {
      'south': lat - latDelta,
      'north': lat + latDelta,
      'west': lon - lonDelta,
      'east': lon + lonDelta,
    };
  }
}
