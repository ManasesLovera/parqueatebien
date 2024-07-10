import 'package:equatable/equatable.dart';

abstract class VehicleEvent extends Equatable {
  const VehicleEvent();

  @override
  List<Object> get props => [];
}

class FetchLicencePlates extends VehicleEvent {
  final String governmentId;

  const FetchLicencePlates(this.governmentId);

  @override
  List<Object> get props => [governmentId];
}

class SelectLicencePlate extends VehicleEvent {
  final String selectedPlate;

  const SelectLicencePlate(this.selectedPlate);

  @override
  List<Object> get props => [selectedPlate];
}

class FetchVehicleDetails extends VehicleEvent {
  final String selectedPlate;

  const FetchVehicleDetails(this.selectedPlate);

  @override
  List<Object> get props => [selectedPlate];
}
