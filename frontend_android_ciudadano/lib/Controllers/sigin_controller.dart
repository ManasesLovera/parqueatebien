import 'package:frontend_android_ciudadano/Api/logIn_User/user_login_api.dart';

Future<bool> signUserIncontroller(
  String username,
  String password,
) async {
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
    final result = await LoginApi.signIn(
      username,
      password,
    );
    if (result == true) {
      return true;
    } else if (result == 409) {
      return Future.error(
          'Ciudadano aun no esta activo, espere a ser aceptado.');
    } else if (result == 404) {
      return Future.error('Este ciudadano aun no tiene cuenta.');
    } else {
      return Future.error(
          'Por favor, Verifique Usuario y Contraseña, Incorrectos.');
    }
  } catch (e) {
    return Future.error(
        'Se produjo un error durante el inicio de sesión. Por favor, inténtelo de nuevo más tarde.');
  }
}
