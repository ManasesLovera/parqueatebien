import 'package:permission_handler/permission_handler.dart';

// Función para solicitar permisos de ubicación.
Future<bool> requestLocationPermission() async {
  // Solicita el permiso de ubicación.
  PermissionStatus status = await Permission.location.request();
  // Retorna true si el permiso fue concedido.
  return status == PermissionStatus.granted;
}
