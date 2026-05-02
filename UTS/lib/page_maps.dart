import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PageMainMaps extends StatefulWidget {
  const PageMainMaps({super.key});

  @override
  State<PageMainMaps> createState() => _PageMainMapsState();
}

class _PageMainMapsState extends State<PageMainMaps> {
  MapType _mapType = MapType.normal;
  bool showMarkers = true;

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId("djamil"),
      position: LatLng(-0.9436, 100.3694),
      infoWindow: InfoWindow(title: "RSUP Dr. M. Djamil Padang"),
    ),
    const Marker(
      markerId: MarkerId("yos_sudarso"),
      position: LatLng(-0.9495, 100.3547),
      infoWindow: InfoWindow(title: "RS Yos Sudarso"),
    ),
    const Marker(
      markerId: MarkerId("unand"),
      position: LatLng(-0.9147, 100.4582),
      infoWindow: InfoWindow(title: "RS Universitas Andalas"),
    ),
    const Marker(
      markerId: MarkerId("bunda"),
      position: LatLng(-0.9502, 100.3601),
      infoWindow: InfoWindow(title: "RS Bunda Padang"),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Peta Rumah Sakit Padang"),
        actions: [
          PopupMenuButton<MapType>(
            onSelected: (MapType type) {
              setState(() {
                _mapType = type;
              });
            },
            itemBuilder: (context) => <PopupMenuEntry<MapType>>[
              const PopupMenuItem(
                value: MapType.normal,
                child: Text("Normal"),
              ),
              const PopupMenuItem(
                value: MapType.satellite,
                child: Text("Satellite"),
              ),
              const PopupMenuItem(
                value: MapType.hybrid,
                child: Text("Hybrid"),
              ),
              const PopupMenuItem(
                value: MapType.terrain,
                child: Text("Terrain"),
              ),
            ],
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(-0.95, 100.35), // pusat Padang
          zoom: 13,
        ),
        mapType: _mapType,
        markers: showMarkers ? _markers : {},
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(showMarkers ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          setState(() {
            showMarkers = !showMarkers;
          });
        },
      ),
    );
  }
}
