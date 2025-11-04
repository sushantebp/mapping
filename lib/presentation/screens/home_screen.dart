import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:auto_route/annotations.dart';
import 'package:latlong2/latlong.dart';

import 'package:mapping/core/core.dart';
import 'package:mapping/data/data.dart';
import 'package:mapping/presentation/presentation.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchPosition();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Widget loaded(PositionModel position) {
    final latLng = LatLng(position.lat, position.lng);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapController.move(latLng, 15.0);
    });

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(initialCenter: latLng, initialZoom: 15.0),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: AppConstant.appPackageName,
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: latLng,
              child: const Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 40,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget failure(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ToastUtils.showError(message);
    });
    return Center(
      child: Text(message, style: const TextStyle(color: Colors.red)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.map),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return state.when(
            initial: () => const InitialWidget(),
            loading: () => const LoadingWidget(),
            loaded: loaded,
            failure: failure,
          );
        },
      ),
    );
  }
}

class InitialWidget extends StatelessWidget {
  const InitialWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Welcome!"));
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
