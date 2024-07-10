import 'dart:convert';
import 'package:frontend_android_ciudadano/Models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class RegisterApi {
  final Logger _logger = Logger();

  Future<dynamic> register(User user) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.209:8089/api/citizen/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    _logger.i('Request body: ${jsonEncode(user.toJson())}');
    _logger.i('Response status: ${response.statusCode}');
    _logger.i('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400) {
      _logger.e('Datos Invalidos: ${response.statusCode}');
      return 400;
    } else if (response.statusCode == 409) {
      _logger.e('Usuario ya existe: ${response.statusCode}');
      return 409;
    }
    return false;
  }
}
