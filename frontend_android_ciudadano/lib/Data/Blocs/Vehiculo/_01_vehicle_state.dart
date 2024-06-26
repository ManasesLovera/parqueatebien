import 'package:equatable/equatable.dart';

abstract class VehicleState extends Equatable {
  const VehicleState();

  @override
  List<Object> get props => [];
}

class VehicleInitial extends VehicleState {}

class VehicleLoading extends VehicleState {}

class VehicleLoaded extends VehicleState {
  final List<String> licencePlates;

  const VehicleLoaded(this.licencePlates);

  @override
  List<Object> get props => [licencePlates];
}

class VehicleError extends VehicleState {
  final String error;

  const VehicleError(this.error);

  @override
  List<Object> get props => [error];
}
