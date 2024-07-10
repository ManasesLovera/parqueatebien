
import 'package:equatable/equatable.dart';

abstract class VehicleEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchVehicleDetails extends VehicleEvent {
  final String plate;

  FetchVehicleDetails(this.plate);

  @override
  List<Object?> get props => [plate];
}

class PlateTextChanged extends VehicleEvent {
  final String text;

  PlateTextChanged(this.text);

  @override
  List<Object?> get props => [text];
}
