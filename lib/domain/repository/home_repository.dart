import 'package:mapping/core/core.dart';
import 'package:mapping/data/data.dart';

abstract class HomeRepository {
  Future<Result<PositionModel>> getCurrentLocation();
}
