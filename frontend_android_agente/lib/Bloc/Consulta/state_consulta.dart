import 'package:equatable/equatable.dart';

abstract class VehicleState extends Equatable {
  const VehicleState();

  @override
  List<Object?> get props => [];
}

// Estado inicial del vehículo.
class VehicleInitial extends VehicleState {
  const VehicleInitial();
}

// Estado de carga mientras se obtienen los detalles del vehículo.
class VehicleLoading extends VehicleState {
  const VehicleLoading();
}

// Estado cuando los detalles del vehículo se han cargado correctamente.
class VehicleLoaded extends VehicleState {
  final Map<String, dynamic> vehicleData; // Datos del vehículo.
  final double lat; // Latitud del vehículo.
  final double lon; // Longitud del vehículo.

  const VehicleLoaded({
    required this.vehicleData,
    required this.lat,
    required this.lon,
  });

  @override
  List<Object?> get props => [vehicleData, lat, lon]; // Propiedades del estado.
}

// Estado cuando ocurre un error al obtener los detalles del vehículo.
class VehicleError extends VehicleState {
  final String message; // Mensaje de error.

  const VehicleError(this.message);

  @override
  List<Object?> get props => [message]; // Propiedades del estado.
}
