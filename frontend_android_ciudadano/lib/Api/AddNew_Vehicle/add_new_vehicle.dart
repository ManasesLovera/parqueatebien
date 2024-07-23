import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Clase para manejar la lógica de agregar un vehículo a través de la API
class AddNewVehicleApi {
  // Inicializa el logger para registro de eventos
  static final Logger _logger = Logger();

  // Método para agregar un vehículo
  Future<bool> addVehicleNew({
    required String governmentId,
    required String licensePlate,
    required String registrationDocument,
    required String model,
    required String year,
    required String color,
  }) async {
    const url = 'http://192.168.0.209:8089/api/citizen/vehicle';

    try {
      // Obtiene el token de autenticación almacenado en las preferencias compartidas
      final token = await _getToken();
      if (token == null) {
        _logger.e('No token found. Please login first.');
        return false;
      }

      // Realiza una petición POST a la API
      final response = await http
          .post(
            Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
            // Codifica los datos del vehículo a JSON
            body: jsonEncode(<String, String>{
              "governmentId": governmentId,
              "licensePlate": licensePlate,
              "registrationDocument": registrationDocument,
              "model": model,
              "year": year,
              "color": color,
            }),
          )
          .timeout(const Duration(seconds: 60));

      // Log de la respuesta
      _logger.i('Response status: ${response.statusCode}');
      _logger.i('Response body: ${response.body}');

      // Manejo de la respuesta según el código de estado
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Vehículo agregado exitosamente
        return true;
      } else if (response.statusCode == 400) {
        // Solicitud incorrecta
        _logger.e('Bad request: ${response.body}');
        return false;
      } else if (response.statusCode == 409) {
        // Conflicto (vehículo ya existe)
        _logger.e('Conflict: ${jsonDecode(response.body)['Message']}');
        return false;
      } else {
        // Error inesperado
        _logger.e('Unexpected error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Manejo de excepciones
      _logger.e('Error adding vehicle: $e');
      return false;
    }
  }

  // Método privado para obtener el token de autenticación almacenado
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      token = token.replaceAll('"', ''); // Elimina comillas adicionales
    }
    return token;
  }
}
