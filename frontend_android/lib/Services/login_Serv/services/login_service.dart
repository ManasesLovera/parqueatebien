import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class LoginSendData {
  static final Logger _logger = Logger();

  static Future<bool> signIn(String username, String password) async {
    const url = 'http://192.168.0.236:8089/users/login/{role}';
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'GovernmentID': username,
              'Password': password,
            }),
          )
          .timeout(const Duration(seconds: 5));

      switch (response.statusCode) {
        case 200:
          _logger.i('Inicio de sesión exitoso');
          return true;
        case 401:
          _logger.e('Unauthorized - Wrong Password');
          return false;
        case 404:
          _logger.e('Not Found');
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
