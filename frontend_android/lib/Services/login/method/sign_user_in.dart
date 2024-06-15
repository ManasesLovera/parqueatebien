import 'dart:async';
import 'package:frontend_android/Services/login/api/api_login.dart';

Future<bool> signUserIn(
  String governmentID,
  String password,
) async {
  if (governmentID.isEmpty || password.isEmpty) {
    return Future.error(
        'Por favor, ingrese tanto el nombre de usuario como la contraseña.');
  }
  try {
    final success = await LoginSendData.signIn(governmentID, password);
    if (success) {
      return true;
    } else {
      return Future.error(
          'Error durante el Inicio De Sesión. Por favor, inténtelo de nuevo.');
    }
  } catch (e) {
    return Future.error(
        'Se produjo un error durante el inicio de sesión. Por favor, inténtelo de nuevo más tarde.');
  }
}
