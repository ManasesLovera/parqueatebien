import 'package:flutter/material.dart';
import 'package:frontend_android/presentation/screen_00_login/login_screen_p0.dart';
import 'package:frontend_android/presentation/screen_01_camera/camera_screen_p1.dart';

void main() async => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Retiramos el debug icon
        debugShowCheckedModeBanner: false,
        // Ruta por defecto
        initialRoute: '/login',
        // rutas de acceso
        routes: {
          '/login': (context) => Login(),
          // Solo la muestra si el login es exitoso
          '/camera': (context) => const Camera(),
        });
  }
}
