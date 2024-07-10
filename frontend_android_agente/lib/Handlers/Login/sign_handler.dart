import 'package:flutter/material.dart';

import 'dart:async';

import 'package:frontend_android/Controllers/Login/sigin_controller.dart';
import 'package:frontend_android/Handlers/Consulta/dialog_success_error_consulta.dart';

Future<void> sign(
  BuildContext context,
  TextEditingController governmentIDController,
  TextEditingController passwordController,
  String role,
) async {
  final String governmentID = governmentIDController.text;
  final String password = passwordController.text;

  try {
    final success = await controllersignUserIn(governmentID, password, role);
    if (success) {
      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  } catch (error) {
    if (!context.mounted) return;
    showUniversalSuccessErrorDialogConsulta(context, error.toString(), false);
  }
}
