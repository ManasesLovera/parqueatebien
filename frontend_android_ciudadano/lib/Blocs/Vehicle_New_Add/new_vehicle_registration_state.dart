import 'package:equatable/equatable.dart';

// Clase abstracta para los estados del registro de un nuevo vehículo
abstract class NewVehicleRegistrationState extends Equatable {
  const NewVehicleRegistrationState();

  @override
  List<Object> get props => [];
}

// Estado inicial del registro de un nuevo vehículo
class NewVehicleRegistrationInitial extends NewVehicleRegistrationState {}

// Estado de carga durante el registro de un nuevo vehículo
class NewVehicleRegistrationLoading extends NewVehicleRegistrationState {}

// Estado de éxito después del registro de un nuevo vehículo
class NewVehicleRegistrationSuccess extends NewVehicleRegistrationState {}

// Estado de fallo durante el registro de un nuevo vehículo
class NewVehicleRegistrationFailure extends NewVehicleRegistrationState {
  final String error;

  const NewVehicleRegistrationFailure({required this.error});

  @override
  List<Object> get props => [error];
}
