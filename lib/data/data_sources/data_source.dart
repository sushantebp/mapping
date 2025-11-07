import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapping/core/core.dart';
import 'package:mapping/data/data.dart';

abstract class DataSource {
  Future<Result<Position>> getPosition();
  Future<Result<PlaceModel>> getPlaceInfo(String query);

  Future<Result<List<CafeModel>>> getCafe();
  Future<Result<List<PlaceOfWorshipModel>>> getPlaceOfWorship();
}

class DataSourceImpl extends DataSource {
  final PermissonService _permissonService;
  final NetworkService _networkService;
  DataSourceImpl(this._permissonService, this._networkService);
  @override
  Future<Result<Position>> getPosition() async {
    try {
      final position = await _permissonService.determinePosition();
      return Right(position);
    } on LocationException catch (e) {
      return Left(e);
    } catch (e) {
      throw UnknownException("Something went wrong accessing position : $e");
    }
  }

  @override
  Future<Result<PlaceModel>> getPlaceInfo(String query) async {
    try {
      final response = await _networkService.getSearchData(query);
      if (response?.data is List && response?.data.isNotEmpty) {
        final placeJson = response?.data[0] as Map<String, dynamic>;
        final place = PlaceModel.fromJson(placeJson);
        return Right(place);
      } else {
        return Left(LocationException("No place info found for query"));
      }
    } on LocationException catch (e) {
      return Left(e);
    } catch (e) {
      throw UnknownException("Something went wrong accessing place info : $e");
    }
  }

  @override
  Future<Result<List<CafeModel>>> getCafe() async {
    try {
      final response = await _networkService.getCafeList();
      if (response?.data != null) {
        final data = response?.data as Map<String, dynamic>;

        final elements = data['elements'] as List<dynamic>;

        final List<CafeModel> cafeList = elements
            .map((e) => CafeModel.fromJson(e))
            .toList();

        return Right(cafeList);
      } else {
        return Left(FetchCafeException("No cafe data found"));
      }
    } on FetchCafeException catch (e) {
      return Left(
        FetchCafeException("Failed to fetch cafe data: ${e.message}"),
      );
    } catch (e) {
      return Left(FetchCafeException("An unexpected error occurred: $e"));
    }
  }

  @override
  Future<Result<List<PlaceOfWorshipModel>>> getPlaceOfWorship() async {
    try {
      final response = await _networkService.getPlaceOfWorship();

      if (response?.data != null) {
        final data = response?.data as Map<String, dynamic>;
        final elements = data['elements'] as List<dynamic>;

        final List<PlaceOfWorshipModel> placeOfWorshipList = elements
            .map((data) => PlaceOfWorshipModel.fromJson(data))
            .toList();

        return Right(placeOfWorshipList);
      } else {
        return Left(
          FetchPlaceOfWorshipException("No places of worship data found"),
        );
      }
    } on FetchPlaceOfWorshipException catch (e) {
      return Left(
        FetchPlaceOfWorshipException(
          "Failed to fetch places of worship data: ${e.message}",
        ),
      );
    } catch (e) {
      return Left(
        FetchPlaceOfWorshipException("An unexpected error occurred: $e"),
      );
    }
  }
}
