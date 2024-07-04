import 'dart:convert';
import 'package:frontend_android_ciudadano/Data/Models/NuevoRegistro/Users/user_model.dart';
import 'package:http/http.dart' as http;

class RegisterApi {
  Future<bool> register(User user) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.168:8089/api/citizen/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
