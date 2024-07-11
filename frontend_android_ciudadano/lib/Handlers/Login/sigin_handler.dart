import 'package:flutter/material.dart';
import 'dart:async';
import 'package:frontend_android_ciudadano/Controllers/sigin_controller.dart';
import 'package:frontend_android_ciudadano/Handlers/Login/dialog_success_error_consulta.dart';

Future<void> signHandler(
  BuildContext context,
  TextEditingController usernameController,
  TextEditingController passwordController,
) async {
  final String username = usernameController.text;
  final String password = passwordController.text;

  try {
    final success = await signUserIncontroller(username, password);
    if (success) {
      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  } catch (error) {
    if (!context.mounted) return;
    showUniversalSuccessErrorDialog(context, error.toString(), false);
  }
}
