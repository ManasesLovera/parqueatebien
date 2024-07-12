import 'package:equatable/equatable.dart';

abstract class NewVehicleRegistrationState extends Equatable {
  const NewVehicleRegistrationState();

  @override
  List<Object> get props => [];
}

class NewVehicleRegistrationInitial extends NewVehicleRegistrationState {}

class NewVehicleRegistrationLoading extends NewVehicleRegistrationState {}

class NewVehicleRegistrationSuccess extends NewVehicleRegistrationState {}

class NewVehicleRegistrationFailure extends NewVehicleRegistrationState {
  final String error;

  const NewVehicleRegistrationFailure({required this.error});

  @override
  List<Object> get props => [error];
}
