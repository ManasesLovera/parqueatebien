import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  final Logger _logger = Logger();

  Future<bool> _requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    return status == PermissionStatus.granted;
  }

  Future<Position?> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _logger.e('Location services are disabled.');
        return null;
      }

      bool permissionGranted = await _requestLocationPermission();
      if (!permissionGranted) {
        _logger.e('Location permissions are denied.');
        return null;
      }

      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      _logger.e('Error retrieving location: $e');
      return null;
    }
  }
}
