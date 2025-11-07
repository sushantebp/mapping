import 'package:mapping/core/core.dart';
import 'package:mapping/data/data.dart';

abstract class HomeRepository {
  Future<Result<PositionModel>> getCurrentLocation();
  Future<Result<PositionModel>> fetchPlaceInfo(String query);

  Future<Result<List<CafeModel>>> getCafe();
  Future<Result<List<PlaceOfWorshipModel>>> getPlaceOfWorship();
}
