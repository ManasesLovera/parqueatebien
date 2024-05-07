import 'package:flutter/material.dart';
import 'package:frontend_android/location/location_service/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

// Use logger FrameWork
final Logger _logger = Logger();

class GetLocationMethod {
  Future<Position?> getCurrentLocation(BuildContext context) async {
    try {
      final locationService = LocationService();
      Position? position = await locationService.getCurrentLocation();
      if (position != null) {
        return position;
      } else {
        _logger.e('Error Fatal !, Localization');
        // Using Future
        return Future.error(
            "Location service is disabled or permission denied");
        /*
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
      */
        // } catch (e) {
      }
    } catch (e) {
      //print('Error: $e');
      _logger.e('Error Fatal!: Current Locations');
      return Future.error("Fatal Error: Could not retrieve current location");
    }
  }
}
