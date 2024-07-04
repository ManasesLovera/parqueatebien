abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String username;
  final String password;

  LoginSubmitted(this.username, this.password);
}

class ClearError extends LoginEvent {}
