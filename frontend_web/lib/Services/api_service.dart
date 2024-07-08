import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/citizen.dart';

class ApiService {
  static Future<Citizen?> getCitizen(String licensePlate) async {
    final response = await http.get(
      Uri.parse('http://locahost:8089/api/reporte/$licensePlate'),
    );

    switch (response.statusCode) {
      case 200:
        return Citizen.fromJson(json.decode(response.body));
      case 400:
        throw Exception('Invalid License Plate');
      case 404:
        return null; // Citizen not found
      default:
        throw Exception('Failed to load citizen');
    }
  }
}
