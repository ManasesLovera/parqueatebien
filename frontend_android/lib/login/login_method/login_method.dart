import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend_android/login/login_service/login_send_data.dart';

Future<void> signUserIn(
  context,
  TextEditingController usernameController,
  TextEditingController passwordController,
) async {
  final String username = usernameController.text;
  final String password = passwordController.text;
  try {
    // validamos si no estan vacios
    if (username.isNotEmpty && password.isNotEmpty) {
      // enviamos
      final success = await LoginSendData.signIn(username, password);
      // si el bool es true 1
      if (success) {
        /* Exito y mostramos con una alerta grafica y vamos a la pantalla tomar foto*/
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Exito'),
              content: const Text('¡Inicio de sesión exitoso!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    // Navigate to the next screen (replace 'NextScreen' with your screen)
                    Navigator.pushReplacementNamed(context, '/camera');
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // si el bool es false !, mostramos de igual manera el mensaje
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text(
                  'Error durante el Inicio De Sesión. Por favor, inténtelo de nuevo.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      // Mostramos mensaje en caso de que los campos user y password esten vacios
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('! Aviso'),
            content: const Text(
                'Por favor, ingrese tanto el nombre de usuario como la contraseña.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // cerramos dialogo
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
    // Cualquier otra cosa, exeption.
  } catch (e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text(
              'Se produjo un error durante el inicio de sesión. Por favor, inténtelo de nuevo más tarde.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
