import 'package:equatable/equatable.dart';

// Clase abstracta para los eventos relacionados con vehículos
abstract class VehicleEvent extends Equatable {
  const VehicleEvent();

  @override
  List<Object> get props => [];
}

// Evento para obtener las placas de los vehículos
class FetchLicencePlates extends VehicleEvent {
  final String governmentId;

  const FetchLicencePlates(this.governmentId);

  @override
  List<Object> get props => [governmentId];
}

// Evento para seleccionar una placa de vehículo
class SelectLicencePlate extends VehicleEvent {
  final String selectedPlate;

  const SelectLicencePlate(this.selectedPlate);

  @override
  List<Object> get props => [selectedPlate];
}

// Evento para obtener los detalles de un vehículo por su placa
class FetchVehicleDetails extends VehicleEvent {
  final String selectedPlate;

  const FetchVehicleDetails(this.selectedPlate);

  @override
  List<Object> get props => [selectedPlate];
}
