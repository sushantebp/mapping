import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapping/core/core.dart';
import 'package:mapping/data/data.dart';

abstract class LocationLocalDataSource {
  Future<Result<Position>> getPosition();
  Future<Result<PlaceModel>> getPlaceInfo(String query);
}

class LocationLocalDataSourceImpl extends LocationLocalDataSource {
  final PermissonService _permissonService;
  final NetworkService _networkService;
  LocationLocalDataSourceImpl(this._permissonService, this._networkService);
  @override
  Future<Result<Position>> getPosition() async {
    try {
      final position = await _permissonService.determinePosition();
      return Right(position);
    } on LocationException catch (e) {
      return Left(e);
    } catch (e) {
      throw UnknownnException("Something went wrong accessing position : $e");
    }
  }

  @override
  Future<Result<PlaceModel>> getPlaceInfo(String query) async {
    try {
      final response = await _networkService.getData(query);
      // Assuming response.data is a List<dynamic> with place JSON objects
      if (response?.data is List && response?.data.isNotEmpty) {
        // Parse the first place from the list
        final placeJson = response?.data[0] as Map<String, dynamic>;
        final place = PlaceModel.fromJson(placeJson);
        return Right(place);
      } else {
        return Left(LocationException("No place info found for query"));
      }
    } on LocationException catch (e) {
      return Left(e);
    } catch (e) {
      throw UnknownnException("Something went wrong accessing place info : $e");
    }
  }
}
