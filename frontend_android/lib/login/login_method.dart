import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class LoginMethod {
  static final Logger _logger = Logger();
  static Future<void> signIn(String username, String password) async {
    const url = 'http://localhost:8089/ciudadanos';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        _logger.i('Inicio de sesión exitoso');
      } else {
        _logger.e('Error durante el inicio de sesión: ${response.statusCode}');
      }
    } catch (e) {
      _logger.e('Error: $e');
    }
  }
}
