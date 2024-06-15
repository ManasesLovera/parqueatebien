import 'package:flutter/material.dart';
import 'package:frontend_android/presentation/Consulta/Consultar_Reporte/_00_buscar_plate.dart';
import 'package:frontend_android/presentation/Reportes/Crear_Reporte/_04_success_screen.dart';
import 'package:frontend_android/presentation/Welcome/Login/_00_login.dart';
import 'package:frontend_android/presentation/Welcome/Login/_01_forgot_.dart';
import 'package:frontend_android/presentation/Reportes/Crear_Reporte/_00_reporte.dart';
import 'package:frontend_android/presentation/Reportes/Crear_Reporte/_01_nuevo_reporte.dart';
import 'package:frontend_android/routes/screen_routes/confirmation/confirmation_screen.dart';
import 'package:frontend_android/routes/screen_routes/errors/error_screen.dart';
import 'package:frontend_android/routes/screen_routes/photos/report_photo_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/login': (context) => const Login(),
    '/WelcomeNewReport': (context) => const WelcomeNewReport(),
    '/NewReport': (context) => const NewReportScreen(),
    '/newreportfoto': (context) => buildNewReportPhotoScreen(context),
    '/Forgot': (context) => const Forgot(),
    '/confirmation': (context) => buildConfirmationScreen(context),
    '/success': (context) => const SuccessScreen(),
    '/error': (context) => buildErrorScreen(context),
    '/consult': (context) => const EnterPlateNumberScreen(),
  };
}
