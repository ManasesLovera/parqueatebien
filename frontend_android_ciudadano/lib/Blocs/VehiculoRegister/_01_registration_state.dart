import 'package:equatable/equatable.dart';

abstract class VehicleRegistrationState extends Equatable {
  const VehicleRegistrationState();

  @override
  List<Object> get props => [];
}

class VehicleRegistrationInitial extends VehicleRegistrationState {}

class VehicleRegistrationLoading extends VehicleRegistrationState {}

class VehicleRegistrationSuccess extends VehicleRegistrationState {}

class VehicleRegistrationFailure extends VehicleRegistrationState {
  final String error;

  const VehicleRegistrationFailure({required this.error});

  @override
  List<Object> get props => [error];
}
