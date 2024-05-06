import 'package:flutter/material.dart';
import 'package:frontend_android/location/location_service/location_service.dart';
import 'package:geolocator/geolocator.dart';

class GetLocationMethod {
  Future<Position?> getCurrentLocation(BuildContext context) async {
    try {
      final locationService = LocationService();
      Position? position = await locationService.getCurrentLocation();
      if (position != null) {
        return position;
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error Localización"),
            content: const Text(
                "No se pudo Obtener la Localización !\nAsegurese que este encendida.!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
