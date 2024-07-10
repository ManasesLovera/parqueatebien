import 'package:equatable/equatable.dart';
import 'package:frontend_android_ciudadano/Models/user_model.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterSubmitted extends RegisterEvent {
  final User user;

  const RegisterSubmitted(this.user);

  @override
  List<Object> get props => [user];
}
