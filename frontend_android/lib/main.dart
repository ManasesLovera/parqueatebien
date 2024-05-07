import 'package:flutter/material.dart';
import 'package:frontend_android/presentation/screen_00_login/login_screen_p0.dart';

void main() async => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //For testing
      home: Login(),
      //  home: Camera(),
    );
  }
}
