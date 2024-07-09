import 'package:flutter/material.dart';
import 'package:frontend_android/Pages/_02_2_Consulta/_00_buscar_plate.dart';
import 'package:frontend_android/Pages/_02_1_Reporte/_02_foto.dart';
import 'package:frontend_android/Pages/_02_1_Reporte/_03_confirmation.dart';
import 'package:frontend_android/Pages/_02_1_Reporte/_05_error.dart';
import 'package:frontend_android/Pages/_00.1_Forgot/_01_forgot_.dart';
import 'package:frontend_android/Pages/_00_Login/_00_login.dart';
import 'package:frontend_android/Pages/_01_Welcome/welcome.dart';
import 'package:frontend_android/Pages/_02_1_Reporte/_01_reporte.dart';
import 'package:frontend_android/Pages/_02_1_Reporte/_04_success.dart';

class AppRoutes {
  static const String login = '/login';
  static const String forgot = '/forgot';
  static const String welcome = '/welcome';
  static const String report = '/report';
  static const String foto = '/foto';
  static const String confirmation = '/confirmation';
  static const String success = '/success';
  static const String error = '/error';
  static const String consult = '/consult';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const Login());
      case forgot:
        return MaterialPageRoute(builder: (_) => const Forgot());
      case welcome:
        return MaterialPageRoute(builder: (_) => const Welcome());
      case report:
        return MaterialPageRoute(builder: (_) => const ReportScreen());
      case foto:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => NewReportPhotoScreen(
            plateNumber: args['plateNumber'],
            vehicleType: args['vehicleType'],
            color: args['color'],
            address: args['address'],
            latitude: args['latitude'],
            longitude: args['longitude'],
          ),
        );
      case confirmation:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ConfirmationScreen(
            plateNumber: args['plateNumber'],
            vehicleType: args['vehicleType'],
            color: args['color'],
            address: args['address'],
            latitude: args['latitude'],
            longitude: args['longitude'],
            imageFileList: args['imageFileList'],
          ),
        );
      case success:
        return MaterialPageRoute(builder: (_) => const SuccessScreen());
      case error:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ErrorScreen(errorMessage: args['errorMessage']),
        );
      case consult:
        return MaterialPageRoute(
            builder: (_) => const EnterPlateNumberScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Login());
    }
  }
}
