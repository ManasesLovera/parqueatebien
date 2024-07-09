
import 'package:equatable/equatable.dart';

abstract class VehicleState extends Equatable {
  const VehicleState();

  @override
  List<Object?> get props => [];
}

class VehicleInitial extends VehicleState {
  const VehicleInitial();
}

class VehicleLoading extends VehicleState {
  const VehicleLoading();
}

class VehicleLoaded extends VehicleState {
  final Map<String, dynamic> vehicleData;
  final double lat;
  final double lon;

  const VehicleLoaded({
    required this.vehicleData,
    required this.lat,
    required this.lon,
  });

  @override
  List<Object?> get props => [vehicleData, lat, lon];
}

class VehicleError extends VehicleState {
  final String message;

  const VehicleError(this.message);

  @override
  List<Object?> get props => [message];
}
