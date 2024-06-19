import 'package:frontend_android_ciudadano/entities/car.dart';

abstract class VehicleRepository {
  Future<Car> fetchVehicleDetails(String plateNumber);
}
