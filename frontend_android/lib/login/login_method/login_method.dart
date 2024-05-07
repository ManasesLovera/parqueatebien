import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend_android/login/login_service/login_send_data.dart';

Future<void> signUserIn(
  BuildContext context,
  TextEditingController usernameController,
  TextEditingController passwordController,
) async {
  final String username = usernameController.text;
  final String password = passwordController.text;
  try {
    if (username.isNotEmpty && password.isNotEmpty) {
      final success = await LoginSendData.signIn(username, password);
      if (success) {
        // Show a success message as an alert dialog
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
        // Show an error message as an alert dialog
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
      // Show a message indicating empty fields
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
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  } catch (e) {
    // Show an error message if an exception occurs
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
