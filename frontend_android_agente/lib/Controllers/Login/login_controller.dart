import 'dart:async';
import 'package:frontend_android/APis/login_api.dart';
import 'package:frontend_android/Models/user_model.dart';

Future<bool> methodControllerLoginFuture(
  String governmentID,
  String password,
  String role,
) async {
  // Verifica si el ID del gobierno o la contraseña están vacíos.
  if (governmentID.isEmpty || password.isEmpty) {
    return Future.error(
        'Por favor, ingrese tanto el nombre de usuario como la contraseña.'); // Retorna un error si faltan datos.
  }
  try {
    // Crea un objeto UserModel con los datos proporcionados.
    final usermodel =
        UserModel(username: governmentID, password: password, role: role);
    // Intenta realizar el login llamando al método API.
    final success = await ClasLoginApi.methodLoginApiFuture(usermodel);
    if (success) {
      return true; // Retorna verdadero si el login fue exitoso.
    } else {
      return Future.error(
          'Por favor, Verifique Usuario y Contraseña, Incorrectos'); // Retorna un error si el login falla.
    }
  } catch (e) {
    return Future.error(
        'Se produjo un error durante el inicio de sesión. Por favor, inténtelo de nuevo más tarde.'); // Retorna un error si ocurre una excepción.
  }
}
