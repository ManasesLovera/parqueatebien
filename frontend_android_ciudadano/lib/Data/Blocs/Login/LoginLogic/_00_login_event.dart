abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String username;
  final String password;
  final String role;

  LoginSubmitted(this.username, this.password, this.role);
}

class ClearError extends LoginEvent {}
