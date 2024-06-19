import 'dart:convert';
import 'package:frontend_android_ciudadano/Models/car_model.dart';
import 'package:frontend_android_ciudadano/entities/car.dart';
import 'package:frontend_android_ciudadano/repositories/vehicle_repository.dart';
import 'package:http/http.dart' as http;

class VehicleRepositoryApi implements VehicleRepository {
  final http.Client client;
  final String baseUrl;

  VehicleRepositoryApi(this.client, this.baseUrl);

  @override
  Future<Car> fetchVehicleDetails(String plateNumber) async {
    final response =
        await client.get(Uri.parse('$baseUrl/ciudadanos/$plateNumber'));
    if (response.statusCode == 200) {
      return CarModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch vehicle details');
    }
  }
}
