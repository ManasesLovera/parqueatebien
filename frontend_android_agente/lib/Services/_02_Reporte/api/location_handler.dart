import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class LocationService {
  final Logger _logger = Logger();

  Future<bool> _requestPermissions() async {
    PermissionStatus foregroundStatus =
        await Permission.locationWhenInUse.request();
    PermissionStatus backgroundStatus =
        await Permission.locationAlways.request();

    if (foregroundStatus.isGranted && backgroundStatus.isGranted) {
      _logger.i("Foreground and background location permissions granted.");
      return true;
    } else {
      _logger.e("Location permissions not granted.");
      return false;
    }
  }

  Future<Position?> getCurrentLocation(
      Function(String) showLocationDialog) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _logger.e("Location services are disabled.");
      showLocationDialog(
          "Los servicios de ubicación están deshabilitados. Por favor, actívalos.");
      await _waitForLocationServicesEnabled();
    }

    bool permissionsGranted = await _requestPermissions();
    if (!permissionsGranted) {
      _logger.e("Location permissions are not granted.");
      return null;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _logger
          .i("Current location: ${position.latitude}, ${position.longitude}");
      return position;
    } catch (e) {
      _logger.e("Error getting current location: $e");
      return null;
    }
  }

  Future<void> _waitForLocationServicesEnabled() async {
    while (!await Geolocator.isLocationServiceEnabled()) {
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}
