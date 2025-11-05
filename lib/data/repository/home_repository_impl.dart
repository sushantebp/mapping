import 'package:fpdart/fpdart.dart';
import 'package:mapping/core/core.dart';
import 'package:mapping/data/data.dart';
import 'package:mapping/domain/domain.dart';

class HomeRepositoryImpl extends HomeRepository {
  final LocationLocalDataSource _localDataSource;
  HomeRepositoryImpl(this._localDataSource);
  @override
  Future<Result<PositionModel>> getCurrentLocation() async {
    try {
      final result = await _localDataSource.getPosition();
      return result.fold((failure) => Left(failure), (position) {
        final positionModel = PositionModel(
          lat: position.latitude,
          lng: position.longitude,
        );
        return Right(positionModel);
      });
    } catch (e) {
      return Left(UnknownnException("Something went wrong: $e"));
    }
  }

  @override
  Future<Result<PositionModel>> fetchPlaceInfo(String query) async {
    try {
      final result = await _localDataSource.getPlaceInfo(query);
      return result.fold((failure) => Left(failure), (placeModel) {
        final positionModel = PositionModel(
          lat: double.parse(placeModel.lat),
          lng: double.parse(placeModel.lon),
        );
        return Right(positionModel);
      });
    } catch (e) {
      return Left(
        UnknownnException("Something went wrong fetching place info: $e"),
      );
    }
  }
}
