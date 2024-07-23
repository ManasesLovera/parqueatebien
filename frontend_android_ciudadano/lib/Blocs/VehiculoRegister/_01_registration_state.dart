import 'package:equatable/equatable.dart';

// Clase abstracta para los estados relacionados con el registro de vehículos
abstract class VehicleRegistrationState extends Equatable {
  const VehicleRegistrationState();

  @override
  List<Object> get props => [];
}

// Estado inicial del registro de vehículos
class VehicleRegistrationInitial extends VehicleRegistrationState {}

// Estado de carga durante el registro de vehículos
class VehicleRegistrationLoading extends VehicleRegistrationState {}

// Estado de éxito después del registro de un vehículo
class VehicleRegistrationSuccess extends VehicleRegistrationState {}

// Estado de fallo durante el registro de un vehículo
class VehicleRegistrationFailure extends VehicleRegistrationState {
  final String error;

  const VehicleRegistrationFailure({required this.error});

  @override
  List<Object> get props => [error];
}
