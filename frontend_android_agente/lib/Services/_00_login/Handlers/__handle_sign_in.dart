import 'package:flutter/material.dart';
import 'package:frontend_android/Services/_00_login/Controller/__controller_sign_user_in.dart';
import 'package:frontend_android/Services/_00_login/dialogs_for_login/__error_dialog.dart';

import 'dart:async';

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
      Navigator.pushReplacementNamed(context, '/report_or_consult');
    }
  } catch (error) {
    if (!context.mounted) return;
    errorDialog(context, error.toString());
  }
}
