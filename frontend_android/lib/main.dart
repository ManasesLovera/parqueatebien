import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/presentation/screen_00_login_aut/auth_forgot/forgot_.dart';
import 'package:frontend_android/presentation/screen_00_login_aut/auth_login/login.dart';
import 'package:frontend_android/presentation/screen_01_camera/camera_screen_p1.dart';

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
          initialRoute: '/forgot',
          routes: {
            '/login': (context) => const Login(),
            '/forgot': (context) => const Forgot(),
            '/camera': (context) => const Camera(),
          },
        );
      },
    );
  }
}
