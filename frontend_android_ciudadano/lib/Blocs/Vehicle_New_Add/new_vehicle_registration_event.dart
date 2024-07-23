import 'package:equatable/equatable.dart';

// Clase abstracta para los eventos del registro de un nuevo vehículo
abstract class NewVehicleRegistrationEvent extends Equatable {
  const NewVehicleRegistrationEvent();

  @override
  List<Object> get props => [];
}

// Evento para registrar un nuevo vehículo
class RegisterNewVehicle extends NewVehicleRegistrationEvent {
  final String governmentId;
  final String licensePlate;
  final String vehicleType;
  final String vehicleColor;
  final String model;
  final String year;
  final String matricula;

  const RegisterNewVehicle({
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
