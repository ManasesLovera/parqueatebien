import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<Position?> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw 'Location services are disabled.';
      }

      PermissionStatus permission = await Permission.location.status;
      if (permission == PermissionStatus.denied) {
        permission = await Permission.location.request();
        if (permission == PermissionStatus.denied) {
          throw 'Location permissions are denied.';
        }
      }

      if (permission == PermissionStatus.permanentlyDenied) {
        throw 'Location permissions are permanently denied, we cannot request permissions.';
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
