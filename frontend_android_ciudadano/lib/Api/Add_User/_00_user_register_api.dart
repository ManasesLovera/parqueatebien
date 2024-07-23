import 'dart:convert';
import 'package:frontend_android_ciudadano/Models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

// Clase para manejar la lógica de registro de usuario a través de la API
class RegisterApi {
  // Inicializa el logger para registro de eventos
  final Logger _logger = Logger();

  // Método para registrar un usuario
  Future<dynamic> register(User user) async {
    // Realiza una petición POST a la API
    final response = await http.post(
      Uri.parse('http://192.168.0.209:8089/api/citizen/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // Codifica el objeto usuario a JSON
      body: jsonEncode(user.toJson()),
    );

    // Log de la solicitud y la respuesta
    _logger.i('Request body: ${jsonEncode(user.toJson())}');
    _logger.i('Response status: ${response.statusCode}');
    _logger.i('Response body: ${response.body}');

    // Manejo de la respuesta según el código de estado
    if (response.statusCode == 200) {
      // Registro exitoso
      return true;
    } else if (response.statusCode == 400) {
      // Datos inválidos
      _logger.e('Datos Invalidos: ${response.statusCode}');
      return 400;
    } else if (response.statusCode == 409) {
      // Usuario ya existe
      _logger.e('Usuario ya existe: ${response.statusCode}');
      return 409;
    }
    // Registro fallido por otras razones
    return false;
  }
}
