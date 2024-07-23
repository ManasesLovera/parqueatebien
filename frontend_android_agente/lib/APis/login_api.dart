import 'dart:convert'; // Importa el paquete para convertir datos JSON.
import 'package:frontend_android/Models/user_model.dart'; // Importa el modelo de usuario.
import 'package:http/http.dart'
    as http; // Importa el paquete para realizar solicitudes HTTP.
import 'package:logger/logger.dart'; // Importa el paquete para el registro de logs.
import 'package:shared_preferences/shared_preferences.dart'; // Importa el paquete para el manejo de preferencias compartidas.

// Clase que maneja las peticiones API relacionadas con el login.
class ClasLoginApi {
  static final Logger _logger = Logger(); // Instancia para el registro de logs.

  // Método para realizar el login de un usuario.
  static Future<bool> methodLoginApiFuture(UserModel usermodelobjet) async {
    const url =
        'http://192.168.0.209:8089/api/user/login'; // URL del servicio de login.
    try {
      // Realiza la solicitud POST con los headers y el cuerpo de la solicitud en formato JSON.
      final response = await http
          .post(
            Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
                usermodelobjet.toJson()), // Codifica el objeto usuario a JSON.
          )
          .timeout(const Duration(
              seconds:
                  5)); // Establece un tiempo límite de 5 segundos para la solicitud.

      _logger.i(
          'Response status: ${response.statusCode}'); // Log del estado de la respuesta.
      _logger.i(
          'Response body: ${response.body}'); // Log del cuerpo de la respuesta.

      if (response.statusCode == 200) {
        // Si la respuesta es exitosa (200), decodifica los datos JSON.
        final responseData = jsonDecode(response.body);
        final rawToken = responseData['token'];
        final role = responseData['role'];
        final token =
            rawToken.replaceAll('"', ''); // Elimina comillas del token.
        _logger.i('Login successful'); // Log de éxito.

        // Almacena el token y el rol en las preferencias compartidas.
        final prefs = await SharedPreferences.getInstance();
        await Future.wait([
          prefs.setString('loggedInUser', usermodelobjet.username),
          prefs.setString('token', token),
          prefs.setString('role', role),
        ]);

        _logger.i('Role stored: $role'); // Log del rol almacenado.

        return true; // Retorna true si el login fue exitoso.
      } else if (response.statusCode == 404) {
        // Manejo de error si el usuario no se encuentra (404).
        _logger.e('Usuario no encontrado');
      } else if (response.statusCode == 409) {
        // Manejo de error si el usuario o contraseña son incorrectos (409).
        _logger.e('Usuario y/o contraseña incorrectos');
      } else if (response.statusCode == 400) {
        // Manejo de error si el rol no es válido (400).
        _logger.e('Rol no es valido.');
      } else {
        // Manejo de otros errores inesperados.
        _logger.e('Error inesperado: ${response.statusCode}');
      }
      return false; // Retorna false si hubo algún error.
    } catch (e) {
      // Manejo de excepciones durante el proceso de login.
      _logger.e('Error during login: $e');
      return false; // Retorna false si ocurrió una excepción.
    }
  }
}
