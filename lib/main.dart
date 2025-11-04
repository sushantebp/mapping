import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapping/core/core.dart';
import 'package:mapping/core/di/di.dart';
import 'package:mapping/domain/repository/home_repository.dart';
import 'package:mapping/presentation/cubit/home_cubit.dart';

void main() {
  initDependencies();
  runApp(const MappingApp());
}

class MappingApp extends StatelessWidget {
  const MappingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => HomeCubit(sl<HomeRepository>()))],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        routerConfig: AppRouter.instance.config(),
      ),
    );
  }
}
