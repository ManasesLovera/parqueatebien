import 'package:flutter/material.dart';
import 'package:frontend_android/Services/login/dialogs_for_login/error_dialog.dart';
import 'package:frontend_android/Services/login/dialogs_for_login/success_dialog.dart';
import 'package:frontend_android/Services/login/method/sign_user_in.dart';
import 'dart:async';

Future<void> handleSignIn(
  BuildContext context,
  TextEditingController governmentIDController,
  TextEditingController passwordController,
) async {
  final String governmentID = governmentIDController.text;
  final String password = passwordController.text;

  try {
    final success = await signUserIn(governmentID, password);
    if (success) {
      if (!context.mounted) return;
      successDialog(context, () {
        Navigator.of(context).pop();
        Navigator.pushReplacementNamed(context, '/WelcomeNewReport');
      });
    }
  } catch (error) {
    if (!context.mounted) return;
    errorDialog(context, error.toString());
  }
}
