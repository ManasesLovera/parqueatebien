import 'package:flutter/material.dart';
import 'package:frontend_android/presentation/Reportes/Crear_Reporte/_03_confirmation_screen.dart';

Widget buildConfirmationScreen(BuildContext context) {
  final args = ModalRoute.of(context)?.settings.arguments as Map;
  return ConfirmationScreen(
    plateNumber: args['plateNumber'],
    vehicleType: args['vehicleType'],
    color: args['color'],
    address: args['address'],
    latitude: args['latitude'],
    longitude: args['longitude'],
    imageFileList: args['imageFileList'],
  );
}
