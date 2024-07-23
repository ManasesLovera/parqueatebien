import 'package:geolocator/geolocator.dart';

class LocationService {
  // Método para obtener el stream de la posición del usuario.
  Stream<Position> getLocationStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high, // Alta precisión en la ubicación.
        distanceFilter: 10, // Notificar cambios en la posición cada 10 metros.
      ),
    );
  }

  // Método para obtener la ubicación actual del usuario.
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null; // Retorna null si el servicio de ubicación no está habilitado.
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null; // Retorna null si los permisos de ubicación son denegados.
      }
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy
            .high); // Retorna la posición actual con alta precisión.
  }

  // Método para solicitar permisos de ubicación.
  Future<bool> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    // Retorna true si los permisos de ubicación son otorgados.
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  // Método para verificar si el servicio de ubicación está habilitado.
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }
}
