
import 'package:equatable/equatable.dart';

abstract class VehicleEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Evento para obtener detalles de un vehículo.
class FetchVehicleDetails extends VehicleEvent {
  final String plate; // Placa del vehículo.

  FetchVehicleDetails(this.plate);

  @override
  List<Object?> get props => [plate]; // Propiedades del evento.
}

// Evento para manejar el cambio de texto de la placa.
class PlateTextChanged extends VehicleEvent {
  final String text; // Texto de la placa.

  PlateTextChanged(this.text);

  @override
  List<Object?> get props => [text]; // Propiedades del evento.
}
