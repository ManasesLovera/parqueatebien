import 'package:flutter/material.dart';

import 'package:frontend_android/routes/screen_routes/confirmation/confirmation_screen.dart';
import 'package:frontend_android/routes/screen_routes/errors/error_screen.dart';
import 'package:frontend_android/routes/screen_routes/photos/report_photo_screen.dart';
import 'package:frontend_android/views/_00.1_Forgot/_01_forgot_.dart';
import 'package:frontend_android/views/_00_Login/_00_login.dart';
import 'package:frontend_android/views/_01_Reporte_O_Consulta/reporte_or_consult.dart';
import 'package:frontend_android/views/_02_Reportes/_01_nuevo_reporte.dart';
import 'package:frontend_android/views/_02_Reportes/_04_success_screen.dart';
import 'package:frontend_android/views/_03_Consulta/_00_buscar_plate.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/login': (context) => const Login(),
    '/forgot': (context) => const Forgot(),
    '/report_or_consult': (context) => const ReportorConsult(),
    '/report': (context) => const ReportScreen(),
    '/foto': (context) => photoScreen(context),
    '/confirmation': (context) => confirmationScreen(context),
    '/success': (context) => const SuccessScreen(),
    '/error': (context) => errorScreen(context),
    '/consult': (context) => const EnterPlateNumberScreen(),
  };
}
