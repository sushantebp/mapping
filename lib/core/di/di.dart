import 'package:get_it/get_it.dart';
import 'package:mapping/core/core.dart';

final GetIt sl = GetIt.instance;

void initDependencies() {
  sl.registerSingleton<PermissonService>(PermissonService());
}
