import 'dart:convert';
import 'package:frontend_android/Services/change_status_dto.dart';
import 'package:http/http.dart' as http;

import 'package:logger/logger.dart';

class ApiService {
  static final Logger _logger = Logger();

  static Future<bool> updateVehicleStatus(
      ChangeStatusDTO changeStatusDTO) async {
    const String baseUrl =
        'https://parqueatebiendemo.azurewebsites.net/ciudadanos/updateStatus';
    final Uri url = Uri.parse(baseUrl);

    try {
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
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
