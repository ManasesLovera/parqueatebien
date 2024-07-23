import 'dart:convert'; // Importa el paquete para convertir datos JSON.
import 'package:http/http.dart'
    as http; // Importa el paquete para realizar solicitudes HTTP.
import 'package:logger/logger.dart'; // Importa el paquete para el registro de logs.

// Clase que maneja las consultas al servicio de vehículos.
class VehicleService {
  // URL base del servicio de reportes de vehículos.
  static const String _baseUrl = 'http://192.168.0.209:8089/api/reporte/';
  final Logger _logger = Logger(); // Instancia para el registro de logs.

  // Método para obtener detalles de un vehículo por su placa.
  Future<Map<String, dynamic>> fetchVehicleDetails(String plate) async {
    final String endpoint =
        plate; // Define el endpoint usando la placa del vehículo.
    final Uri url =
        Uri.parse('$_baseUrl$endpoint'); // Construye la URL completa.

    _logger.d(
        'Attempting to fetch vehicle details from $url...'); // Log de depuración.

    try {
      // Realiza la solicitud GET con un tiempo límite de 45 segundos.
      final response = await http.get(url).timeout(const Duration(seconds: 45));

      if (response.statusCode == 200) {
        // Si la respuesta es exitosa (200), decodifica los datos JSON.
        final vehicleData = jsonDecode(response.body);
        _logger.d(
            'Vehicle details fetched successfully: $vehicleData'); // Log de éxito.
        return vehicleData; // Retorna los datos del vehículo.
      } else if (response.statusCode == 404) {
        // Si el vehículo no se encuentra (404), lanza una excepción.
        _logger.w('Vehicle not found: $plate'); // Log de advertencia.
        throw Exception('Vehicle not found.');
      } else {
        // Si hay un error en el servidor, lanza una excepción.
        _logger.e(
            'Server error with status code: ${response.statusCode}'); // Log de error.
        throw Exception('Server error.');
      }
    } catch (e) {
      // Si hay un error en la conexión, lanza una excepción.
      _logger.e('Failed to connect to the server: $e'); // Log de error.
      throw Exception('Failed to connect to the server');
    }
  }
}
