import 'package:dio/dio.dart';
import 'package:mapping/core/core.dart';

class DioClient {
  late final Dio dio;
  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        headers: {'User-Agent': 'MyFlutterApp/1.0 (myemail@example.com)'},
      ),
    );
  }
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;
  DioClient get instance => _instance;
}

class NetworkService {
  NetworkService._internal();
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;
  NetworkService get instance => _instance;
  final DioClient _dioClient = DioClient();

  Future<Response?> getData(String query) async {
    try {
      final response = await _dioClient.instance.dio.get(
        "/search",
        queryParameters: {'q': query, 'format': AppConfig.format},
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        return null;
      }
    } catch (e) {
      throw UnknownnException("Something went wrong fetching place info : $e");
    }
  }
}
