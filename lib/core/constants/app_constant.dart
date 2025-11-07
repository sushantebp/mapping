class AppConstant {
  static const String appPackageName = "com.example.mapping";

  static const String search = "/search";

  static const String interpreter = "/interpreter";

  static const String cafeQuery = '''
[out:json];
node["amenity"="cafe"](27.65,85.25,27.80,85.40);
out;
''';

  static const String placeOfWorshipQuery = '''
[out:json];
node["amenity"="place_of_worship"]["religion"~"hindu|buddhist"](27.65,85.25,27.80,85.40);
out;
''';
}
