import 'package:flutter/material.dart';
//import 'package:frontend_android/presentation/00_splash/_00_splash.dart';
import 'package:frontend_android/presentation/screen_00_login/login_screen_p0.dart';
import 'package:frontend_android/presentation/screen_01_camera/camera_screen_p1.dart';

void main() => runApp(const Main());

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
       //    '/splash': (context) => const SplashScreen(),
          '/login': (context) => Login(),
          '/camera': (context) => const Camera(),
        });
  }
}
