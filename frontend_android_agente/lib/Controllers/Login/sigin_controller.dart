import 'dart:async';
import 'package:frontend_android/APis/_00_login.dart';
import 'package:frontend_android/Models/user_model.dart';

Future<bool> methodControllerLoginFuture(
  String governmentID,
  String password,
  String role,
) async {
  if (governmentID.isEmpty || password.isEmpty) {
    return Future.error(
        'Por favor, ingrese tanto el nombre de usuario como la contraseña.');
  }
  try {
    final usermodel =
        UserModel(username: governmentID, password: password, role: role);
    final success = await ClasLoginApi.methodLoginApiFuture(usermodel);
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
