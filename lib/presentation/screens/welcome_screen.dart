import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:auto_route/annotations.dart';
import 'package:latlong2/latlong.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MapController mapController = MapController();

    return Scaffold(
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: LatLng(51.509364, -0.128928),
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.mapping',
          ),
        ],
      ),
    );
  }
}
