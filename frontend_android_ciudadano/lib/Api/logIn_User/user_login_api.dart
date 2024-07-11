import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginApi {
  static final Logger _logger = Logger();
  static const String _url = 'http://192.168.0.209:8089/api/citizen/login';
  static SharedPreferences? _prefs;

  static Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<void> _storeCredentials(
      String username, String token, String governmentId) async {
    await _prefs?.setString('loggedInUser', username);
    await _prefs?.setString('token', token);
    await _prefs?.setString('governmentId', governmentId);
  }

  static Future<dynamic> signIn(String username, String password) async {
    await _initPrefs();

    try {
      final response = await http
          .post(
            Uri.parse(_url),
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

      switch (response.statusCode) {
        case 200:
          final token = response.body.replaceAll('"', '');
          final governmentId = username.replaceAll('-', '');
          _logger.i(
              'Inicio de sesión exitoso, Token: $token, Government ID: $governmentId');
          await _storeCredentials(username, token, governmentId);
          return true;
        case 409:
          _logger.e('Ciudadano aun no esta activo, espere a ser aceptado');
          return 409;
        case 404:
          _logger.e('Ciudadano no encontrado');
          return 404;
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
