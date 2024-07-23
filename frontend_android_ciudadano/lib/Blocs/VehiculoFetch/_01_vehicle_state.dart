import 'package:equatable/equatable.dart';

// Clase abstracta para los estados relacionados con vehículos
abstract class VehicleState extends Equatable {
  const VehicleState();

  @override
  List<Object> get props => [];
}

// Estado inicial de los vehículos
class VehicleInitial extends VehicleState {}

// Estado de carga durante la obtención de datos de vehículos
class VehicleLoading extends VehicleState {}

// Estado de éxito después de cargar las placas de los vehículos
class VehicleLoaded extends VehicleState {
  final List<String> licencePlates;

  const VehicleLoaded(this.licencePlates);

  @override
  List<Object> get props => [licencePlates];
}

// Estado de error durante la obtención de datos de vehículos
class VehicleError extends VehicleState {
  final String error;

  const VehicleError(this.error);

  @override
  List<Object> get props => [error];
}

// Estado de éxito después de cargar los detalles de un vehículo
class VehicleDetailsLoaded extends VehicleState {
  final Map<String, dynamic> vehicleDetails;

  const VehicleDetailsLoaded(this.vehicleDetails);

  @override
  List<Object> get props => [vehicleDetails];
}

// Estado cuando no se encuentra el vehículo
class VehicleNotFound extends VehicleState {}
