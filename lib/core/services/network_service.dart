import 'package:dio/dio.dart';
import 'package:mapping/core/core.dart';

class NetworkService {
  NetworkService._internal();
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;
  NetworkService get instance => _instance;

  final _osmDioClient = OsmDioClient();
  final _overPassDioClient = OverpassDioClient();

  Future<Response?> getSearchData(String query) async {
    try {
      final response = await _osmDioClient.instance.dio.get(
        AppConstant.search,
        queryParameters: {'q': query, 'format': AppConfig.format},
      );
      if (response.statusCode == 200) return response;
      return null;
    } catch (e) {
      throw UnknownException("Something went wrong fetching place info: $e");
    }
  }

  Future<Response?> getCafeList(
    double south,
    double west,
    double north,
    double east,
  ) async {
    try {
      final response = await _overPassDioClient.instance.dio.post(
        AppConstant.interpreter,
        data: AppConstant.cafeQuery(
          south: south,
          west: west,
          north: north,
          east: east,
        ),
      );
      if (response.statusCode == 200) return response;
      return null;
    } catch (e) {
      throw UnknownException("Error fetching cafes: $e");
    }
  }

  Future<Response?> getPlaceOfWorship(
    double south,
    double west,
    double north,
    double east,
  ) async {
    try {
      final response = await _overPassDioClient.instance.dio.post(
        AppConstant.interpreter,
        data: AppConstant.placeOfWorshipQuery(
          south: south,
          west: west,
          north: north,
          east: east,
        ),
      );

      if (response.statusCode == 200) return response;
      return null;
    } catch (e) {
      throw UnknownException("Error fetching places of worship: $e");
    }
  }
}
