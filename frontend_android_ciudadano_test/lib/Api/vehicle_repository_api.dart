import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend_android_ciudadano/entities/car.dart';
import 'package:frontend_android_ciudadano/models/car_model.dart';
import 'package:frontend_android_ciudadano/repositories/vehicle_repository.dart';

class VehicleRepositoryApi implements VehicleRepository {
  final http.Client client;
  final String baseUrl;

  VehicleRepositoryApi(this.client, this.baseUrl);

  @override
  Future<Car> fetchVehicleDetails(String plateNumber) async {
    final uri = Uri.parse('$baseUrl/ciudadanos/$plateNumber');
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return CarModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch vehicle details');
    }
  }
}
