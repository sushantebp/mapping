import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static final osmBaseUrl = dotenv.env['OSM_API'] ?? "";
  static const String format = "jsonv2";

  static final overpassBaseUrl = dotenv.env['OVERPASS_API'] ?? "";
}
