import 'dart:convert';
import 'dart:io';
import 'package:frontend_android/Services/update_status/change_status_dto.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

var logger = Logger();

class ApiService {
  static const String baseUrl =
      // 'https://parqueatebiendemo.azurewebsites.net/ciudadanos';
      'http://192.168.0.209:8089/ciudadanos';

  static Future<http.Response> createReport(
      Map<String, dynamic> reportData, List<File> images) async {
    List<Map<String, String>> photos = [];
    for (var image in images) {
      List<int> imageBytes = await image.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      photos.add({
        "fileType": "data:image/jpeg;base64,",
        "file": base64Image,
      });
    }
    reportData['photos'] = photos;

    var uri = Uri.parse(baseUrl);
    var response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(reportData),
    );

    logger.i('Request Body: ${jsonEncode(reportData)}');
    logger.i('Response Status: ${response.statusCode}');
    logger.i('Response Body: ${response.body}');

    switch (response.statusCode) {
      case 200:
        logger.i('Success: ${response.body}');
        break;
      case 400:
        logger.w('Bad Request: ${response.reasonPhrase}');
        break;
      case 500:
        logger.e('Server Error: ${response.reasonPhrase}');
        break;
      default:
        logger.e(
            'Unexpected Error: ${response.statusCode} - ${response.reasonPhrase}');
        break;
    }

    return response;
  }

  static updateVehicleStatus(ChangeStatusDTO changeStatusDTO) {}
}
