import 'package:flutter/material.dart';
import 'package:frontend_android/presentation/Reportes/Crear_Reporte/_02_foto_nuevo_reporte.dart';


Widget buildNewReportPhotoScreen(BuildContext context) {
  final args = ModalRoute.of(context)?.settings.arguments as Map;
  return NewReportPhotoScreen(
    plateNumber: args['plateNumber'],
    vehicleType: args['vehicleType'],
    color: args['color'],
    address: args['address'],
    latitude: args['latitude'],
    longitude: args['longitude'],
  );
}
