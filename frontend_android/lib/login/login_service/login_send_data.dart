import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class LoginSendData {
  static final Logger _logger = Logger();
  static Future<bool> signIn(String username, String password) async {
    const url = 'http://locahost:8089/ciudadanos';
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
          )
          .timeout(const Duration(seconds: 2));
      switch (response.statusCode) {
        // For testing, para ir a la otra pantalla
        //  case 400:
        case 200:
          _logger.i('Inicio de sesión exitoso');
          return true;
        case 400:
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
