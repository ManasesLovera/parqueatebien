import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/presentation/login/auth_login/login.dart';
import 'package:frontend_android/presentation/screen_01_camera/camera_screen_p1.dart';
import 'package:frontend_android/presentation/welcome_screen/_00_reporte.dart';
import 'package:frontend_android/presentation/welcome_screen/_01_nuevo_reporte.dart';
import 'package:frontend_android/presentation/welcome_screen/_02_foto_nuevo_reporte.dart';

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
          initialRoute: '/newreportfoto',
          routes: {
            '/login': (context) => const Login(),
            '/report': (context) => const WelcomeNewReport(),
            '/newreport': (context) => const NewReportScreen(),
            '/newreportfoto': (context) => const NewReportPhotoScreen(),
            '/camera': (context) => const Camera(),
          },
        );
      },
    );
  }
}
