import 'package:flutter/material.dart';
import 'package:frontend_android/location/location_service/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

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
      }
    } catch (e) {
      //print('Error: $e');
      _logger.e('Error Fatal!: Current Locations');
      return Future.error("Fatal Error: Could not retrieve current location");
    }
  }
}
