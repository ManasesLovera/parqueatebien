import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSendData {
  static final Logger _logger = Logger();

  Future<dynamic> signIn(String username, String password) async {
    const url = 'http://192.168.0.168:8089/api/citizen/login';
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              "governmentId": username.replaceAll('-', ''),
              "password": password,
            }),
          )
          .timeout(const Duration(seconds: 60));

      _logger.i('Response status: ${response.statusCode}');
      _logger.i('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final token = response.body.replaceAll('"', '');
        final governmentId = username.replaceAll('-', '');
        _logger.i(
            'Inicio de sesión exitoso, Token: $token, Government ID: $governmentId');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('loggedInUser', username);
        await prefs.setString('token', token);
        await prefs.setString('governmentId', governmentId);
        return true;
      } else if (response.statusCode == 409) {
        _logger.e('Ciudadano aun no esta activo, espere a ser aceptado');
        return 409;
      } else {
        _logger.e('Error inesperado: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      _logger.e('Error durante el inicio de sesión: $e');
      return false;
    }
  }
}