import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend_android/Services/login_/services/login_service.dart';

Future<void> signUserIn(
  context,
  TextEditingController governmentIDController,
  TextEditingController passwordController,
) async {
  final String governmentID = governmentIDController.text;
  final String password = passwordController.text;
  try {
    if (governmentID.isNotEmpty && password.isNotEmpty) {
      final success = await LoginSendData.signIn(governmentID, password);

      if (success) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Exito'),
              content: const Text('¡Inicio de sesión exitoso!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(
                        context, '/WelcomeNewReport');
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
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
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
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
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
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
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
