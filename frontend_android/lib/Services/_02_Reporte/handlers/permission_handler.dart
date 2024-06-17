import 'package:permission_handler/permission_handler.dart';

Future<bool> requestLocationPermission() async {
  PermissionStatus status = await Permission.location.request();
  return status == PermissionStatus.granted;
}
