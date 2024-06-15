import 'package:flutter/material.dart';
import 'package:frontend_android/screens/_02_Reportes/_02_foto_nuevo_reporte.dart';


Widget photoScreen(BuildContext context) {
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
