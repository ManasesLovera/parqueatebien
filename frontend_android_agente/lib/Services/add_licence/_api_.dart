import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

var logger = Logger();

class ApiService {
  static const String baseUrl = 'http://192.168.0.209:8089/api/reporte';

  static Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<http.Response> createReport(
      Map<String, dynamic> reportData, List<File> images) async {
    List<Map<String, String>> photos = [];
    for (var image in images) {
      List<int> imageBytes = await image.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      photos.add({
        "fileType": "data:image/jpeg;base64",
        "file": base64Image,
      });
    }
    reportData['photos'] = photos;

    var token = await _getToken();
    if (token == null) {
      logger.e('No token found. Please login first.');
      throw Exception('No token found.');
    }
    logger.i('Using token: $token');

    var uri = Uri.parse(baseUrl);
    var response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(reportData),
    );

    logger.i('Request Body: ${jsonEncode(reportData)}');
    logger.i('Response Status: ${response.statusCode}');
    logger.i('Response Body: ${response.body}');

    switch (response.statusCode) {
      case 201:
        logger.i('Success: ${response.body}');
        break;
      case 400:
        logger.w('Bad Request: ${response.reasonPhrase}');
        break;
      case 409:
        logger.e('Conflict: ${response.reasonPhrase}');
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
}
