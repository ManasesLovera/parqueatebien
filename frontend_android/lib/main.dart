import 'package:flutter/material.dart';
import 'package:frontend_android/presentation/screen_01_camera/camera_screen_p1.dart';

void main() async => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Camera(),
    );
  }
}
