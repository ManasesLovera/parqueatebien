import 'package:equatable/equatable.dart';

// Clase abstracta para los eventos relacionados con el registro de vehículos
abstract class VehicleRegistrationEvent extends Equatable {
  const VehicleRegistrationEvent();

  @override
  List<Object> get props => [];
}

// Evento para registrar un vehículo
class RegisterVehicle extends VehicleRegistrationEvent {
  final String governmentId;
  final String licensePlate;
  final String vehicleType;
  final String vehicleColor;
  final String model;
  final String year;
  final String matricula;

  const RegisterVehicle({
    required this.governmentId,
    required this.licensePlate,
    required this.vehicleType,
    required this.vehicleColor,
    required this.model,
    required this.year,
    required this.matricula,
  });

  @override
  List<Object> get props => [
        governmentId,
        licensePlate,
        vehicleType,
        vehicleColor,
        model,
        year,
        matricula,
      ];
}

// Evento para obtener el ID del gobierno
class FetchGovernmentId extends VehicleRegistrationEvent {
  final String licensePlate;
  final String vehicleType;
  final String vehicleColor;
  final String model;
  final String year;
  final String matricula;

  const FetchGovernmentId({
    required this.licensePlate,
    required this.vehicleType,
    required this.vehicleColor,
    required this.model,
    required this.year,
    required this.matricula,
  });

  @override
  List<Object> get props =>
      [licensePlate, vehicleType, vehicleColor, model, year, matricula];
}
