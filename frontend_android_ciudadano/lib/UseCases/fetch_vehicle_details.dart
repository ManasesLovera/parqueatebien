import 'package:frontend_android_ciudadano/entities/car.dart';
import 'package:frontend_android_ciudadano/repositories/vehicle_repository.dart';

class FetchVehicleDetails {
  final VehicleRepository repository;

  FetchVehicleDetails({required this.repository});

  Future<Car> execute(String plateNumber) {
    return repository.fetchVehicleDetails(plateNumber);
  }
}
