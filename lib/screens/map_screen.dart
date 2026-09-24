import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const CameraPosition initialPosition = CameraPosition(
    target: LatLng(28.6139, 77.2090),
    zoom: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blood Donor Map"),
        backgroundColor: Colors.red,
      ),
      body: const GoogleMap(
        initialCameraPosition: initialPosition,
        myLocationEnabled: true,
      ),
    );
  }
}