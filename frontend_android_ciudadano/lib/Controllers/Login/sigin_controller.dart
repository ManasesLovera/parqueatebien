import 'package:frontend_android_ciudadano/Api/logIn_User/user_login_api.dart';
import 'package:logger/logger.dart';

Future<bool> signUserInController(String username, String password) async {
  final Logger logger = Logger();

  if (username.isEmpty || password.isEmpty) {
    return Future.error(
        'Por favor, ingrese tanto el nombre de usuario como la contraseña.');
  }

  // Cedula incompleta
  String cedula = username.replaceAll('-', '');
  if (cedula.length != 11) {
    return Future.error('Cédula incompleta. Debe tener 11 dígitos.');
  }

  try {
    final result = await LoginApi.signIn(username, password);
    logger.i('Result: $result'); // Usamos Logger para depuración
    if (result == true) {
      return true;
    } else if (result ==
        'Ciudadano aun no esta activo, espere a ser aceptado.') {
      return Future.error(
          'Ciudadano aun no esta activo, espere a ser aceptado.');
    } else if (result ==
        'El ciudadano no fue aprobado, debes volver a registrarte.') {
      return Future.error(
          'El ciudadano no fue aprobado, debes volver a registrarte.');
    } else if (result == 'Cedula y/o contraseña incorrectos.') {
      return Future.error('Cedula y/o contraseña incorrectos.');
    } else if (result == 'El usuario no existe.') {
      return Future.error('El usuario no existe.');
    } else {
      return Future.error(
          'Por favor, Verifique Usuario y Contraseña, Incorrectos.');
    }
  } catch (e) {
    logger.e('Error durante el inicio de sesión: $e');
    return Future.error(
        'Se produjo un error durante el inicio de sesión. Por favor, inténtelo de nuevo más tarde.');
  }
}
