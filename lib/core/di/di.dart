import 'package:get_it/get_it.dart';
import 'package:mapping/core/core.dart';
import 'package:mapping/data/data.dart';
import 'package:mapping/domain/domain.dart';
import 'package:mapping/presentation/cubit/home_cubit.dart';

final GetIt sl = GetIt.instance;

void initDependencies() {
  sl.registerSingleton<PermissonService>(PermissonService());
  sl.registerSingleton<OsmDioClient>(OsmDioClient());
  sl.registerSingleton<OverpassDioClient>(OverpassDioClient());
  sl.registerSingleton<NetworkService>(NetworkService());

  sl.registerLazySingleton<DataSource>(
    () => DataSourceImpl(sl<PermissonService>(), sl<NetworkService>()),
  );

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl<DataSource>()),
  );
  sl.registerFactory<HomeCubit>(() => HomeCubit(sl<HomeRepository>()));
}
