import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Clase para manejar la lógica de inicio de sesión a través de la API
class LoginApi {
  // Inicializa el logger para registro de eventos
  static final Logger _logger = Logger();

  // Método para iniciar sesión
  static Future<dynamic> signIn(String username, String password) async {
    const url = 'http://192.168.0.209:8089/api/citizen/login';
    try {
      // Realiza una petición POST a la API
      final response = await http
          .post(
            Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            // Codifica los datos del usuario a JSON
            body: jsonEncode(<String, String>{
              "governmentId": username.replaceAll('-', ''),
              "password": password,
            }),
          )
          .timeout(const Duration(seconds: 60));

      // Log de la respuesta
      _logger.i('Response status: ${response.statusCode}');
      _logger.i('Response body: ${response.body}');

      // Manejo de la respuesta según el código de estado
      if (response.statusCode == 200) {
        // Inicio de sesión exitoso, guarda el token y otros datos en las preferencias compartidas
        final token = response.body;
        final governmentId = username.replaceAll('-', '');
        _logger.i(
            'Inicio de sesión exitoso, Token: $token, Government ID: $governmentId');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('loggedInUser', username);
        await prefs.setString('token', token);
        await prefs.setString('governmentId', governmentId);
        return true;
      } else {
        // Manejo de errores según el código de estado
        final responseBody = jsonDecode(response.body);
        if (response.statusCode == 409) {
          _logger.e(responseBody['message']);
          return responseBody['message'];
        } else if (response.statusCode == 404) {
          _logger.e('El usuario no existe');
          return 'El usuario no existe.';
        } else {
          _logger.e('Error inesperado: ${response.statusCode}');
          return 'Error inesperado. Por favor, inténtelo de nuevo más tarde.';
        }
      }
    } catch (e) {
      // Manejo de excepciones
      _logger.e('Error durante el inicio de sesión: $e');
      return 'Se produjo un error durante el inicio de sesión. Por favor, inténtelo de nuevo más tarde.';
    }
  }
}
