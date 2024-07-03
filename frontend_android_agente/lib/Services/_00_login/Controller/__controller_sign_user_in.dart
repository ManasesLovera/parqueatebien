import 'dart:async';
import 'package:frontend_android/Services/_00_login/api/_api_login.dart';

Future<bool> controllersignUserIn(
  String governmentID,
  String password,
  String role,
) async {
  if (governmentID.isEmpty || password.isEmpty) {
    return Future.error(
        'Por favor, ingrese tanto el nombre de usuario como la contraseña.');
  }
  try {
    final success = await LoginSendData.signIn(governmentID, password, role);
    if (success) {
      return true;
    } else {
      return Future.error(
          'Por favor, Verifique Usuario y Contraseña, Incorrectos');
    }
  } catch (e) {
    return Future.error(
        'Se produjo un error durante el inicio de sesión. Por favor, inténtelo de nuevo más tarde.');
  }
}
