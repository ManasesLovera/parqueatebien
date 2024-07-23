import 'dart:convert'; // Importa el paquete para convertir datos JSON.
import 'dart:io'; // Importa el paquete para trabajar con archivos.
import 'package:frontend_android/APis/_04_status_update.dart'; // Importa el archivo para actualizar el estado.
import 'package:http/http.dart'
    as http; // Importa el paquete para realizar solicitudes HTTP.
import 'package:logger/logger.dart'; // Importa el paquete para el registro de logs.
import 'package:shared_preferences/shared_preferences.dart'; // Importa el paquete para el manejo de preferencias compartidas.

// Variable global para el registro de logs.
var logger = Logger();

// Clase que maneja las consultas al servicio de reportes.
class ApiServiceReport {
  // URL base del servicio de reportes.
  static const String baseUrl = 'http://192.168.0.209:8089/api/reporte';

  // Método privado para obtener el token almacenado en las preferencias compartidas.
  static Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Método para crear un reporte con datos y fotos.
  static Future<http.Response> createReport(
      Map<String, dynamic> reportData, List<File> images) async {
    List<Map<String, String>> photos = [];

    // Convierte cada imagen en base64 y la añade a la lista de fotos.
    for (var image in images) {
      List<int> imageBytes = await image.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      photos.add({
        "fileType": "data:image/jpeg;base64",
        "file": base64Image,
      });
    }
    reportData['photos'] = photos; // Añade las fotos a los datos del reporte.

    var token = await _getToken();
    if (token == null) {
      // Si no se encuentra un token, lanza una excepción.
      logger.e('No token found. Please login first.');
      throw Exception('No token found.');
    }
    logger
        .i('Using token: $token'); // Log de información sobre el uso del token.

    var uri = Uri.parse(baseUrl); // Construye la URL completa.
    var response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(reportData), // Codifica los datos del reporte en JSON.
    );

    logger.i(
        'Request Body: ${jsonEncode(reportData)}'); // Log del cuerpo de la solicitud.
    logger.i(
        'Response Status: ${response.statusCode}'); // Log del estado de la respuesta.
    logger.i(
        'Response Body: ${response.body}'); // Log del cuerpo de la respuesta.

    // Manejo de respuestas según el código de estado.
    switch (response.statusCode) {
      case 201:
        logger.i('Success: ${response.body}'); // Log de éxito.
        break;
      case 400:
        logger
            .w('Bad Request: ${response.reasonPhrase}'); // Log de advertencia.
        break;
      case 409:
        logger.e('Conflict: ${response.reasonPhrase}'); // Log de error.
        break;
      case 500:
        logger.e('Server Error: ${response.reasonPhrase}'); // Log de error.
        break;
      default:
        logger.e(
            'Unexpected Error: ${response.statusCode} - ${response.reasonPhrase}'); // Log de error inesperado.
        break;
    }

    return response; // Retorna la respuesta HTTP.
  }

  // Método para actualizar el estado de un vehículo (implementación pendiente).
  static updateVehicleStatus(ChangeStatusDTO changeStatusDTO) {}
}
