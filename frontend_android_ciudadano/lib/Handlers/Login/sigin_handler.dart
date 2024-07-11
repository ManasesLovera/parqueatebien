import 'package:flutter/material.dart';
import 'package:frontend_android_ciudadano/Controllers/Login/sigin_controller.dart';
import 'dart:async';
import 'package:frontend_android_ciudadano/Handlers/Login/dialog_success_error_user.dart';
import 'package:frontend_android_ciudadano/Pages/_01_Welcome/_00_welcome.dart';

Future<void> signHandler(
  BuildContext context,
  TextEditingController usernameController,
  TextEditingController passwordController,
) async {
  final String username = usernameController.text;
  final String password = passwordController.text;

  try {
    final success = await signUserInController(username, password);
    if (success) {
      if (!context.mounted) return;
      showUniversalSuccessErrorDialog(
          context, 'Inicio de sesión exitoso', true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Welcome()),
      );
    }
  } catch (error) {
    if (!context.mounted) return;
    showUniversalSuccessErrorDialog(context, error.toString(), false);
  }
}
