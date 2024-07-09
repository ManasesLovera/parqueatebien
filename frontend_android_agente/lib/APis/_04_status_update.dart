import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServiceUpdate {
  static final Logger _logger = Logger();

  static Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<bool> updateVehicleStatus(
      ChangeStatusDTO changeStatusDTO) async {
    const String baseUrl =
        'http://192.168.0.209:8089/api/reporte/actualizarEstado/';
    final Uri url = Uri.parse(baseUrl);

    try {
      String? token = await _getToken();
      if (token == null) {
        _logger.e('No se encontró el token. Por favor, inicie sesión primero.');
        return false;
      }

      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(changeStatusDTO.toJson()),
      );

      if (response.statusCode == 200) {
        _logger.i('El estatus fue actualizado');
        return true;
      } else {
        _logger.e('Error al actualizar el estado: ${response.body}');
        return false;
      }
    } catch (e) {
      _logger.e('Error al conectar con el servidor: $e');
      return false;
    }
  }
}

class ChangeStatusDTO {
  final String licensePlate;
  final String newStatus;
  final String username;

  ChangeStatusDTO({
    required this.licensePlate,
    required this.newStatus,
    required this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      'licensePlate': licensePlate,
      'newStatus': newStatus,
      'username': username,
    };
  }
}
