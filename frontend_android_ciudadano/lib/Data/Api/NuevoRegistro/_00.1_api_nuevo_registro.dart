import 'dart:convert';
import 'package:frontend_android_ciudadano/Data/Models/NuevoRegistro/User_Extention/user_extensions.dart';
import 'package:frontend_android_ciudadano/Data/Models/NuevoRegistro/Users_Model/user_model.dart';
import 'package:http/http.dart' as http;

class RegisterApi {
  Future<bool> register(User user) async {
    final response = await http.post(
      Uri.parse('https://api.tuapp.com/register'),
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

  registerVehicle(String licensePlate, String vehicleType, String vehicleColor, String model, String year, String matricula) {}
}
