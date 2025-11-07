import 'package:dio/dio.dart';
import 'package:mapping/core/core.dart';

class OverpassDioClient {
  late final Dio dio;

  OverpassDioClient._internal() {
    dio = Dio(BaseOptions(baseUrl: AppConfig.overpassBaseUrl));
  }

  static final OverpassDioClient _instance = OverpassDioClient._internal();
  factory OverpassDioClient() => _instance;
  OverpassDioClient get instance => _instance;
}
