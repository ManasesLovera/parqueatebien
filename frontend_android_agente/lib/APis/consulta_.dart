import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class VehicleService {
  static const String _baseUrl = 'http://192.168.0.209:8089/api/reporte/';
  final Logger _logger = Logger();

  Future<Map<String, dynamic>> fetchVehicleDetails(String plate) async {
    final String endpoint = plate;
    final Uri url = Uri.parse('$_baseUrl$endpoint');

    _logger.d('Attempting to fetch vehicle details from $url...');

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 45));

      if (response.statusCode == 200) {
        final vehicleData = jsonDecode(response.body);
        _logger.d('Vehicle details fetched successfully: $vehicleData');
        return vehicleData;
      } else if (response.statusCode == 404) {
        throw Exception('Vehicle not found.');
      } else {
        throw Exception('Server error.');
      }
    } catch (e) {
      _logger.e('Failed to connect to the server: $e');
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
