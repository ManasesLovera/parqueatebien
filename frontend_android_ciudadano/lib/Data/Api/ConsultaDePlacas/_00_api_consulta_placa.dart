import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ConsultaPlaca {
<<<<<<< HEAD
  final String apiUrlList = 'https://parqueatebiendemo.azurewebsites.net/ciudadanos/ciudadanos';
  final String apiUrlDetails = 'https://parqueatebiendemo.azurewebsites.net/ciudadanos/';

=======
  final String apiUrlList =
      'http://192.168.0.209:8089/ciudadanos/ciudadanos';
  final String apiUrlDetails =
      'http://192.168.0.209:8089/ciudadanos/';
>>>>>>> e1683d22c4ffec8a8beeac7085206058093cf0df
  final Logger _logger = Logger();

  Future<List<String>> fetchLicencePlates() async {
    final response = await http.get(Uri.parse(apiUrlList));
    _logger.i('Fetching licence plates from $apiUrlList');

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<String> licensePlates =
          data.map((item) => item['licensePlate'] as String).toList();
      _logger.i('Fetched licence plates: $licensePlates');
      return licensePlates;
    } else {
      _logger.e(
          'Failed to load licence plates with status code ${response.statusCode}');
      throw Exception('Failed to load licence plates');
    }
  }

  Future<Map<String, dynamic>> fetchVehicleDetails(String licensePlate) async {
    final response = await http.get(Uri.parse('$apiUrlDetails$licensePlate'));
    _logger.i(
        'Fetching details for plate: $licensePlate from $apiUrlDetails$licensePlate');

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      _logger.i('Fetched vehicle details: $data');
      return data;
    } else if (response.statusCode == 404) {
      _logger.w('Vehicle not found for plate: $licensePlate');
      throw Exception('Vehicle not found');
    } else {
      _logger.e(
          'Failed to load vehicle details with status code ${response.statusCode}');
      throw Exception('Failed to load vehicle details');
    }
  }
}
