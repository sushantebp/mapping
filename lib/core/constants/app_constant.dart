class AppConstant {
  static const String appPackageName = "com.example.mapping";
  static const String search = "/search";
  static const String interpreter = "/interpreter";

  static String cafeQuery({
    required double south,
    required double west,
    required double north,
    required double east,
  }) {
    return '''
[out:json];
node["amenity"="cafe"]($south,$west,$north,$east);
out;
''';
  }

  static String placeOfWorshipQuery({
    required double south,
    required double west,
    required double north,
    required double east,
  }) {
    return '''
[out:json];
node["amenity"="place_of_worship"]($south,$west,$north,$east);
out;
''';
  }
}
