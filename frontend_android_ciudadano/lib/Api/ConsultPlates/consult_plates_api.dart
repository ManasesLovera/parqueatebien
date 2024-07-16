import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsultaPlaca {
  final String apiUrlCitizenVehicles =
      'http://192.168.0.209:8089/api/citizen/vehicle/';
  final String apiUrlDetails = 'http://192.168.0.209:8089/api/reporte/';
  final Logger _logger = Logger();

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      token = token.replaceAll('"', ''); // Eliminar comillas adicionales
    }
    return token;
  }

  Future<List<String>> fetchLicencePlates(String governmentId) async {
    final token = await _getToken();
    if (token == null) {
      _logger.e('No token found. Please login first.');
      throw Exception('No token found');
    }
    _logger.i('Using token: $token');

    final response = await http.get(
      Uri.parse('$apiUrlCitizenVehicles$governmentId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    _logger.i(
        'Fetching licence plates for user $governmentId from $apiUrlCitizenVehicles');

    if (response.statusCode == 200) {
      List<String> licencePlates =
          List<String>.from(json.decode(response.body));
      _logger.i('Fetched licence plates: $licencePlates');
      return licencePlates;
    } else if (response.statusCode == 401) {
      _logger.e('Unauthorized request. Invalid token.');
      throw Exception('Unauthorized request. Invalid token.');
    } else if (response.statusCode == 404) {
      _logger.w('Citizen not found for governmentId: $governmentId');
      throw Exception('Citizen not found');
    } else {
      _logger.e(
          'Failed to load licence plates with status code ${response.statusCode}');
      throw Exception('Failed to load licence plates');
    }
  }

  Future<Map<String, dynamic>> fetchVehicleDetails(String licensePlate) async {
    final token = await _getToken();
    if (token == null) {
      _logger.e('No token found. Please login first.');
      throw Exception('No token found');
    }

    final response = await http.get(
      Uri.parse('$apiUrlDetails$licensePlate'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    _logger.i(
        'Fetching details for plate: $licensePlate from $apiUrlDetails$licensePlate');

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      _logger.i('Fetched vehicle details: $data');
      return data;
    } else if (response.statusCode == 401) {
      _logger.e('Unauthorized request. Invalid token.');
      throw Exception('Unauthorized request. Invalid token.');
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


// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:logger/logger.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ConsultaPlaca {
//   final String apiUrlCitizenVehicles =
//       'http://192.168.0.209:8089/api/citizen/vehicle/';
//   final String apiUrlDetails = 'http://192.168.0.209:8089/api/reporte/';
//   final Logger _logger = Logger();

//   Future<String?> _getToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('token');
//   }

//   Future<List<String>> fetchLicencePlates(String governmentId) async {
//     final token = await _getToken();
//     if (token == null) {
//       _logger.e('No token found. Please login first.');
//       throw Exception('No token found');
//     }
//     _logger.i('Using token: $token');

//     final response = await http.get(
//       Uri.parse('$apiUrlCitizenVehicles$governmentId'),
//       headers: {
//         'Authorization': 'Bearer $token',
//       },
//     );
//     _logger.i(
//         'Fetching licence plates for user $governmentId from $apiUrlCitizenVehicles');

//     if (response.statusCode == 200) {
//       List<String> licencePlates =
//           List<String>.from(json.decode(response.body));
//       _logger.i('Fetched licence plates: $licencePlates');
//       return licencePlates;
//     } else if (response.statusCode == 404) {
//       _logger.w('Citizen not found for governmentId: $governmentId');
//       throw Exception('Citizen not found');
//     } else {
//       _logger.e(
//           'Failed to load licence plates with status code ${response.statusCode}');
//       throw Exception('Failed to load licence plates');
//     }
//   }

//   Future<Map<String, dynamic>> fetchVehicleDetails(String licensePlate) async {
//     final token = await _getToken();
//     if (token == null) {
//       _logger.e('No token found. Please login first.');
//       throw Exception('No token found');
//     }

//     final response = await http.get(
//       Uri.parse('$apiUrlDetails$licensePlate'),
//       headers: {
//         'Authorization': 'Bearer $token',
//       },
//     );
//     _logger.i(
//         'Fetching details for plate: $licensePlate from $apiUrlDetails$licensePlate');

//     if (response.statusCode == 200) {
//       Map<String, dynamic> data = json.decode(response.body);
//       _logger.i('Fetched vehicle details: $data');
//       return data;
//     } else if (response.statusCode == 404) {
//       _logger.w('Vehicle not found for plate: $licensePlate');
//       throw Exception('Vehicle not found');
//     } else {
//       _logger.e(
//           'Failed to load vehicle details with status code ${response.statusCode}');
//       throw Exception('Failed to load vehicle details');
//     }
//   }
// }


// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:logger/logger.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ConsultaPlaca {
//   final String apiUrlCitizenVehicles = 'http://192.168.0.209:8089/api/citizen/vehicle/';
//   final String apiUrlDetails = 'http://192.168.0.209:8089/api/reporte/';
//   final Logger _logger = Logger();

//   Future<String?> _getToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('token');
//   }

//   Future<List<String>> fetchLicencePlates(String governmentId) async {
//     final token = await _getToken();
//     if (token == null) {
//       _logger.e('No token found. Please login first.');
//       throw Exception('No token found');
//     }
//     _logger.i('Using token: $token');

//     final response = await http.get(
//       Uri.parse('$apiUrlCitizenVehicles$governmentId'),
//       headers: {
//         'Authorization': 'Bearer $token',
//       },
//     );
//     _logger.i('Fetching licence plates for user $governmentId from $apiUrlCitizenVehicles');

//     if (response.statusCode == 200) {
//       List<String> licencePlates = List<String>.from(json.decode(response.body));
//       _logger.i('Fetched licence plates: $licencePlates');
//       return licencePlates;
//     } else if (response.statusCode == 401) {
//       _logger.e('Unauthorized request. Invalid token.');
//       throw Exception('Unauthorized request. Invalid token.');
//     } else if (response.statusCode == 404) {
//       _logger.w('Citizen not found for governmentId: $governmentId');
//       throw Exception('Citizen not found');
//     } else {
//       _logger.e('Failed to load licence plates with status code ${response.statusCode}');
//       throw Exception('Failed to load licence plates');
//     }
//   }

//   Future<Map<String, dynamic>> fetchVehicleDetails(String licensePlate) async {
//     final token = await _getToken();
//     if (token == null) {
//       _logger.e('No token found. Please login first.');
//       throw Exception('No token found');
//     }

//     final response = await http.get(
//       Uri.parse('$apiUrlDetails$licensePlate'),
//       headers: {
//         'Authorization': 'Bearer $token',
//       },
//     );
//     _logger.i('Fetching details for plate: $licensePlate from $apiUrlDetails$licensePlate');

//     if (response.statusCode == 200) {
//       Map<String, dynamic> data = json.decode(response.body);
//       _logger.i('Fetched vehicle details: $data');
//       return data;
//     } else if (response.statusCode == 401) {
//       _logger.e('Unauthorized request. Invalid token.');
//       throw Exception('Unauthorized request. Invalid token.');
//     } else if (response.statusCode == 404) {
//       _logger.w('Vehicle not found for plate: $licensePlate');
//       throw Exception('Vehicle not found');
//     } else {
//       _logger.e('Failed to load vehicle details with status code ${response.statusCode}');
//       throw Exception('Failed to load vehicle details');
//     }
//   }
// }
