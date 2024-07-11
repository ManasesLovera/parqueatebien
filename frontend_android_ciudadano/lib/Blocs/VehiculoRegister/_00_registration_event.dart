import 'package:equatable/equatable.dart';

abstract class VehicleRegistrationEvent extends Equatable {
  const VehicleRegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegisterVehicle extends VehicleRegistrationEvent {
  final String governmentId; // Agregar este campo
  final String licensePlate;
  final String vehicleType;
  final String vehicleColor;
  final String model;
  final String year;
  final String matricula;

  const RegisterVehicle({
    required this.governmentId, // Agregar este campo
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
        matricula
      ];
}

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
