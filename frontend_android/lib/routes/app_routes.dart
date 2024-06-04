import 'package:flutter/material.dart';
import 'package:frontend_android/presentation/_01_Reporte/_00_reporte.dart';
import 'package:frontend_android/presentation/_01_Reporte/_01_nuevo_reporte.dart';
import 'package:frontend_android/presentation/_01_Reporte/_02_foto_nuevo_reporte.dart';
import 'package:frontend_android/presentation/_00_login/forgot_.dart';
import 'package:frontend_android/presentation/_00_login/login.dart';
import 'package:frontend_android/presentation/_01_Reporte/_03_confirmation_screen.dart';
import 'package:frontend_android/presentation/_01_Reporte/_04_success_screen.dart';
import 'package:frontend_android/presentation/_01_Reporte/_05_error_screen.dart';
import 'package:frontend_android/presentation/_02_Consulta/_00_buscar_plate.dart';
import 'package:image_picker/image_picker.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/login': (context) => const Login(),
    '/WelcomeNewReport': (context) => const WelcomeNewReport(),
    '/NewReport': (context) => const NewReportScreen(),
    '/newreportfoto': (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map;
      return NewReportPhotoScreen(
        plateNumber: args['plateNumber'],
        vehicleType: args['vehicleType'],
        color: args['color'],
        address: args['address'],
        latitude: args['latitude'],
        longitude: args['longitude'],
      );
    },
    '/Forgot': (context) => const Forgot(),
    '/confirmation': (context) {
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
    },
    '/success': (context) => const SuccessScreen(),
    '/error': (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map;
      return ErrorScreen(
        errorMessage: args['errorMessage'],
      );
    },
    '/consult': (context) => const EnterPlateNumberScreen(),
  };
}
