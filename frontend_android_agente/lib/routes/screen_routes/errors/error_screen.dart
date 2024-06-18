import 'package:flutter/material.dart';
import 'package:frontend_android/views/_02_Reportes/_05_error.dart';

Widget errorScreen(BuildContext context) {
  final args = ModalRoute.of(context)?.settings.arguments as Map;
  return ErrorScreen(
    errorMessage: args['errorMessage'],
  );
}
