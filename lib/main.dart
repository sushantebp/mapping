import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:mapping/core/core.dart';
import 'package:mapping/core/di/di.dart';
import 'package:mapping/domain/repository/home_repository.dart';
import 'package:mapping/presentation/presentation.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  initDependencies();
  runApp(const MappingApp());
}

class MappingApp extends StatelessWidget {
  const MappingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit(sl<HomeRepository>())),
        BlocProvider(create: (_) => PlaceCubit(sl<HomeRepository>())),
        BlocProvider(create: (_) => CafeCubit(sl<HomeRepository>())),
        BlocProvider(create: (_) => PlaceOfWorshipCubit(sl<HomeRepository>())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        routerConfig: AppRouter.instance.config(),
      ),
    );
  }
}
