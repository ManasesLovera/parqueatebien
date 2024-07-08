import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSendData {
  static final Logger _logger = Logger();

  static Future<bool> signIn(
      String username, String password, String role) async {
    const url = 'http://192.168.0.209:8089/api/user/login';
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              "username": username,
              "password": password,
              "role": role
            }),
          )
          .timeout(const Duration(seconds: 5));
      _logger.i('Response status: ${response.statusCode}');
      _logger.i('Response body: ${response.body}');

      switch (response.statusCode) {
        case 200:
          final rawToken = response.body;
          final token = rawToken.replaceAll('"', '');
          _logger.i('Inicio de sesión exitoso');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('username', username);
          await prefs.setString('token', token);
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
