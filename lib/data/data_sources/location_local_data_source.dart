import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapping/core/core.dart';

abstract class LocationLocalDataSource {
  Future<Result<Position>> getPosition();
}

class LocationLocalDataSourceImpl extends LocationLocalDataSource {
  final PermissonService _permissonService;
  LocationLocalDataSourceImpl(this._permissonService);
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
}
