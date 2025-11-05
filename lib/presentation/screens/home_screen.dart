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
  final _searchController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchPosition();
  }

  @override
  void dispose() {
    _mapController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget initial() => const Center(child: Text("Welcome!"));

  Widget loading() {
    return const Center(child: CircularProgressIndicator.adaptive());
  }

  Widget loaded(PositionModel position) {
    final latLng = LatLng(position.lat, position.lng);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapController.move(latLng, 15.0);
    });

    return Stack(
      children: [
        FlutterMap(
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
        ),
        Positioned(
          top: 54,
          left: 12,
          right: 12,
          child: Form(
            key: _key,
            child: CustomTextField(
              controller: _searchController,
              isRounded: true,
              placeholder: "Search place",
              prefix: const Icon(Icons.place_outlined),
              showClearButtonOnTyping: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a search term';
                }
                return null;
              },
              onFieldSubmitted: (query) {
                if (_key.currentState?.validate() ?? false) {
                  context.read<PlaceCubit>().searchResult(query);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget failure(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSnackBar(message);
    });
    return Center(
      child: Text(message, style: const TextStyle(color: Colors.red)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<PlaceCubit, PlaceState>(
        listener: (context, state) {
          // when place cubit has postiin
          // lets update in loaded here
          state.whenOrNull(
            loaded: (position) =>
                context.read<HomeCubit>().updatePosition(position),
          );
        },
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state.when(
              initial: initial,
              loading: loading,
              loaded: loaded,
              failure: failure,
            );
          },
        ),
      ),
    );
  }
}
