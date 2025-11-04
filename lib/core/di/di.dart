import 'package:get_it/get_it.dart';
import 'package:mapping/core/core.dart';
import 'package:mapping/data/data.dart';
import 'package:mapping/domain/domain.dart';
import 'package:mapping/presentation/cubit/home_cubit.dart';

final GetIt sl = GetIt.instance;

void initDependencies() {
  sl.registerSingleton<PermissonService>(PermissonService());

  sl.registerLazySingleton<LocationLocalDataSource>(
    () => LocationLocalDataSourceImpl(sl<PermissonService>()),
  );

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl<LocationLocalDataSource>()),
  );
  sl.registerFactory<HomeCubit>(() => HomeCubit(sl<HomeRepository>()));
}
