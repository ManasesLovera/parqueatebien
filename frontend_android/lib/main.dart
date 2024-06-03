import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/presentation/_01_Reporte/_00_reporte.dart';
import 'package:frontend_android/presentation/_01_Reporte/_01_nuevo_reporte.dart';
import 'package:frontend_android/presentation/_01_Reporte/_02_foto_nuevo_reporte.dart';
import 'package:frontend_android/presentation/_00_login/forgot_.dart';
import 'package:frontend_android/presentation/_00_login/login.dart';
import 'package:frontend_android/presentation/_01_Reporte/_03_confirmation_screen.dart';
import 'package:frontend_android/presentation/_01_Reporte/_04_success_screen.dart';
import 'package:frontend_android/presentation/_01_Reporte/_05_error_screen.dart';
import 'package:frontend_android/presentation/_02_Consulta/_00_buscar_plate.dart';

void main() => runApp(const Main());

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/login',
          routes: {
            '/login': (context) => const Login(),
            '/WelcomeNewReport': (context) => const WelcomeNewReport(),
            '/NewReport': (context) => const NewReportScreen(),
            '/newreportfoto': (context) => const NewReportPhotoScreen(),
            '/Forgot': (context) => const Forgot(),
            '/confirmation': (context) =>
                const ConfirmationScreen(imageFileList: []),
            '/success': (context) => const SuccessScreen(),
            '/error': (context) => const ErrorScreen(),
            '/consult': (context) => const EnterPlateNumberScreen(),
          },
        );
      },
    );
  }
}
