import 'package:equatable/equatable.dart';
import 'package:frontend_android_ciudadano/Models/user_model.dart';

// Clase abstracta para los eventos del registro de usuario
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

// Evento para registrar un usuario
class RegisterSubmitted extends RegisterEvent {
  final User user;

  const RegisterSubmitted(this.user);

  @override
  List<Object> get props => [user];
}
