class UserModel {
  String username; // Nombre de usuario.
  String password; // Contraseña del usuario.
  String role; // Rol del usuario.

  // Constructor que inicializa el modelo de usuario con los valores proporcionados.
  UserModel({
    required this.username,
    required this.password,
    required this.role,
  });

  // Método para convertir el modelo de usuario a un mapa JSON.
  Map<String, String> toJson() {
    return {
      'username': username,
      'password': password,
      'role': role,
    };
  }
}
