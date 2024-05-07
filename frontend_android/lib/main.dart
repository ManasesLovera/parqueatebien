import 'package:flutter/material.dart';
import 'package:frontend_android/presentation/screen_00_login/login_screen_p0.dart';
import 'package:frontend_android/presentation/screen_01_camera/camera_screen_p1.dart';

void main() async => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (context) => Login(),
          '/camera': (context) => const Camera(),
          //  home: Camera(),
        });
  }
}
