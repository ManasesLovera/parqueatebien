import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class LoginSendData {
  // mostramos con este loggin framework errores en consolas descriptivos
  static final Logger _logger = Logger();
  //devolvemos bool
  static Future<bool> signIn(String username, String password) async {
    const url = 'http://localhost:8089/ciudadanos';
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'username': username,
              'password': password,
            }),
          ) // si en 2seg no responde, timeout
          .timeout(const Duration(seconds: 2));
      /* For testing, para ir a la otra pantalla si validar user ni password
          usar case 400: en ves de case 200, para con el error hacer login
             */
      switch (response.statusCode) {
        case 400:
          _logger.i('Inicio de sesión exitoso');
          return true;
        case 600:
          _logger.e('Error de cliente: La solicitud es incorrecta.');
          return false;
        case 409:
          _logger.e(
              'Error de cliente: Conflicto con el estado actual del recurso.');
          return false;
        case 500:
          _logger.e('Error de servidor interno: ${response.body}');
          return false;
        default:
          _logger.e('Error inesperado: ${response.statusCode}');
          return false;
      }
    } catch (e) {
      _logger.e('Error durante el inicio de sesión: $e');
      return false;
    }
  }
}
