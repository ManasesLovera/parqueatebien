import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

var logger = Logger();

class ApiService {
  static const String baseUrl =
      'https://parqueatebien.azurewebsites.net/ciudadanos';

  static Future<http.Response> createReport(
      Map<String, dynamic> reportData, List<File> images) async {
    List<Map<String, String>> photos = [];
    for (var image in images) {
      List<int> imageBytes = await image.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      photos.add({
        "fileType": "image/jpeg",
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

    logger.i('Request Body: ${jsonEncode(reportData)}'); // Info level log
    logger.i('Response Status: ${response.statusCode}'); // Info level log
    logger.i('Response Body: ${response.body}'); // Info level log

    return response;
  }
}
