import 'package:equatable/equatable.dart';

// Clase abstracta para los estados del registro de usuario
abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

// Estado inicial del registro de usuario
class RegisterInitial extends RegisterState {}

// Estado de carga durante el registro de usuario
class RegisterLoading extends RegisterState {}

// Estado de éxito después del registro de usuario
class RegisterSuccess extends RegisterState {}

// Estado de fallo durante el registro de usuario
class RegisterFailure extends RegisterState {
  final String error;

  const RegisterFailure(this.error);

  @override
  List<Object> get props => [error];
}
