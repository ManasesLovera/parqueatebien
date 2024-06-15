import 'package:flutter/material.dart';
import 'package:frontend_android/Services/login/Controller/__controller_sign_user_in.dart';
import 'package:frontend_android/Services/login/dialogs_for_login/__error_dialog.dart';

import 'dart:async';

Future<void> sign(
  BuildContext context,
  TextEditingController governmentIDController,
  TextEditingController passwordController,
) async {
  final String governmentID = governmentIDController.text;
  final String password = passwordController.text;

  try {
    final success = await controllersignUserIn(governmentID, password);
    if (success) {
      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, '/WelcomeNewReport');
    }
  } catch (error) {
    if (!context.mounted) return;
    errorDialog(context, error.toString());
  }
}
