import 'dart:convert'; // Importa el paquete para convertir datos JSON.
import 'package:http/http.dart'
    as http; // Importa el paquete para realizar solicitudes HTTP.
import 'package:logger/logger.dart'; // Importa el paquete para el registro de logs.
import 'package:shared_preferences/shared_preferences.dart'; // Importa el paquete para el manejo de preferencias compartidas.

// Clase que maneja las consultas al servicio de actualización de estado de vehículos.
class ApiServiceUpdate {
  static final Logger _logger = Logger(); // Instancia para el registro de logs.

  // Método privado para obtener el token almacenado en las preferencias compartidas.
  static Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Método para actualizar el estado de un vehículo.
  static Future<bool> updateVehicleStatus(
      ChangeStatusDTO changeStatusDTO) async {
    const String baseUrl =
        'http://192.168.0.209:8089/api/reporte/actualizarEstado/';
    final Uri url = Uri.parse(baseUrl); // Construye la URL completa.

    try {
      String? token = await _getToken();
      if (token == null) {
        // Si no se encuentra un token, registra un error y retorna false.
        _logger.e('No se encontró el token. Por favor, inicie sesión primero.');
        return false;
      }

      // Realiza la solicitud PUT con los headers y el cuerpo de la solicitud en formato JSON.
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(changeStatusDTO.toJson()), // Codifica el DTO a JSON.
      );

      if (response.statusCode == 200) {
        // Si la respuesta es exitosa (200), registra un log de éxito y retorna true.
        _logger.i('El estatus fue actualizado');
        return true;
      } else {
        // Si hay un error en la actualización, registra un error y retorna false.
        _logger.e('Error al actualizar el estado: ${response.body}');
        return false;
      }
    } catch (e) {
      // Si hay un error en la conexión, registra un error y retorna false.
      _logger.e('Error al conectar con el servidor: $e');
      return false;
    }
  }
}

// Clase para representar el DTO (Data Transfer Object) de cambio de estado.
class ChangeStatusDTO {
  final String licensePlate; // Placa del vehículo.
  final String newStatus; // Nuevo estado del vehículo.
  final String username; // Nombre de usuario que realiza el cambio.

  ChangeStatusDTO({
    required this.licensePlate,
    required this.newStatus,
    required this.username,
  });

  // Método para convertir el DTO a un mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'licensePlate': licensePlate,
      'newStatus': newStatus,
      'username': username,
    };
  }
}
