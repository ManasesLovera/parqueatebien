import 'package:flutter/material.dart';
import 'package:frontend_android/Controllers/Login/login_controller.dart';
import 'dart:async';
import 'package:frontend_android/Handlers/Consulta/dialog_success_error_consulta.dart';

Future<void> methodHandlerLoginFuture(
  BuildContext context,
  TextEditingController governmentIDController,
  TextEditingController passwordController,
  String role,
) async {
  final String governmentID = governmentIDController
      .text; // Obtiene el ID del gobierno del controlador de texto.
  final String password = passwordController
      .text; // Obtiene la contraseña del controlador de texto.

  try {
    // Llama al método de login del controlador y espera el resultado.
    final success =
        await methodControllerLoginFuture(governmentID, password, role);
    if (success) {
      if (!context.mounted) return; // Verifica si el contexto está montado.
      Navigator.pushReplacementNamed(
          context, '/welcome'); // Navega a la pantalla de bienvenida.
    }
  } catch (error) {
    if (!context.mounted) return; // Verifica si el contexto está montado.
    showUniversalSuccessErrorDialogConsulta(
        context, error.toString(), false); // Muestra un diálogo de error.
  }
}
