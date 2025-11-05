import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static final baseUrl = dotenv.env['OSM_API'] ?? "";
  static const String format = "jsonv2";
}
