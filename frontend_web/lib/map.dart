import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  final double destinationLat;
  final double destinationLon;

  const MapWidget({
    Key? key,
    required this.destinationLat,
    required this.destinationLon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(destinationLat, destinationLon),
        zoom: 13.0,
      ),
      markers: {
        Marker(
          markerId: MarkerId('destination'),
          position: LatLng(destinationLat, destinationLon),
          infoWindow: InfoWindow(
            title: 'Destino',
            snippet: 'Aquí está el destino',
          ),
        ),
      },
      onMapCreated: (controller) {
        // Aquí puedes realizar acciones adicionales cuando se crea el mapa
        // Por ejemplo, añadir interactividad con el mapa
      },
    );
  }
}