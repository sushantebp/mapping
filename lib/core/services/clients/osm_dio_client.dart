import 'package:dio/dio.dart';
import 'package:mapping/core/core.dart';

class OsmDioClient {
  late final Dio dio;
  OsmDioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.osmBaseUrl,
        headers: {'User-Agent': 'MyFlutterApp/1.0 (myemail@example.com)'},
      ),
    );
  }
  static final OsmDioClient _instance = OsmDioClient._internal();
  factory OsmDioClient() => _instance;
  OsmDioClient get instance => _instance;
}
