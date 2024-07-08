import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class LocationService {
  final Logger logger = Logger();

  Future<Position?> getCurrentLocation(
      {Duration timeout = const Duration(seconds: 10)}) async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        logger.w("Location services are disabled.");
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          logger.w("Location permissions are denied.");
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        logger.w("Location permissions are permanently denied.");
        return null;
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: timeout,
      );
    } catch (e) {
      logger.w("Failed to get current location: $e");
      return null;
    }
  }
}
