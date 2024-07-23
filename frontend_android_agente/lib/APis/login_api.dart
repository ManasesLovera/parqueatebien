import 'dart:convert';
import 'package:frontend_android/Models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ClasLoginApi {
  static final Logger _logger = Logger();

  static Future<bool> methodLoginApiFuture(UserModel usermodelobjet) async {
    const url = 'http://192.168.0.209:8089/api/user/login';
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(usermodelobjet.toJson()),
          )
          .timeout(const Duration(seconds: 5));
      _logger.i('Response status: ${response.statusCode}');
      _logger.i('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final rawToken = responseData['token'];
        final role = responseData['role'];
        final token = rawToken.replaceAll('"', '');
        _logger.i('Login successful');

        final prefs = await SharedPreferences.getInstance();
        await Future.wait([
          prefs.setString('loggedInUser', usermodelobjet.username),
          prefs.setString('token', token),
          prefs.setString('role', role),
        ]);

        _logger.i('Role stored: $role');

        return true;
      } else if (response.statusCode == 404) {
        _logger.e('Usuario no encontrado');
      } else if (response.statusCode == 409) {
        _logger.e('Usuario y/o contraseña incorrectos');
      } else if (response.statusCode == 400) {
        _logger.e('Rol no es valido.');
      } else {
        _logger.e('Error inesperado: ${response.statusCode}');
      }
      return false;
    } catch (e) {
      _logger.e('Error during login: $e');
      return false;
    }
  }
}
