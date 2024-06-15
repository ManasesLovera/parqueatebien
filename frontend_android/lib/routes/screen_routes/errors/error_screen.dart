import 'package:flutter/material.dart';
import 'package:frontend_android/presentation/Reportes/Crear_Reporte/_05_error_screen.dart';

Widget buildErrorScreen(BuildContext context) {
  final args = ModalRoute.of(context)?.settings.arguments as Map;
  return ErrorScreen(
    errorMessage: args['errorMessage'],
  );
}
