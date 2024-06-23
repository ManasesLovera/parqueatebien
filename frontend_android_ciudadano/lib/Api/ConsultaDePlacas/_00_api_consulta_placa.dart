import 'dart:convert';
import 'package:http/http.dart' as http;

class ConsultaPlaca {
  final String apiUrl =
      'https://parqueatebiendemo.azurewebsites.net/ciudadanos/ciudadanos';

  Future<List<String>> fetchLicencePlates() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<String> licensePlate =
          data.map((item) => item['licensePlate'] as String).toList();
      return licensePlate;
    } else {
      throw Exception('Failed to load licence plates');
    }
  }
}
