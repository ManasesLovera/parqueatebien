import 'package:frontend_android_ciudadano/Data/Models/NuevoRegistro/Users_Model/user_model.dart';

extension UserExtensions on User {
  Map<String, dynamic> toJson() {
    return {
      'cedula': cedula,
      'nombres': nombres,
      'apellidos': apellidos,
      'correo': correo,
      'password': password,
    };
  }
}
