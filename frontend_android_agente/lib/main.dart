import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/routes/app_routes.dart.dart';

// Función principal que ejecuta la aplicación.
void main() => runApp(const M());

// Clase principal de la aplicación.
class M extends StatelessWidget {
  const M({super.key});

  @override
  Widget build(BuildContext context) {
    // Inicializa ScreenUtil con un tamaño de diseño.
    return ScreenUtilInit(
      designSize: const Size(360, 640), // Tamaño de diseño base.
      builder: (context, child) {
        // Construye el MaterialApp.
        return const MaterialApp(
          debugShowCheckedModeBanner: false, // Oculta el banner de debug.
          initialRoute: AppRoutes.login, // Ruta inicial de la aplicación.
          onGenerateRoute: AppRoutes.generateRoute, // Generador de rutas.
        );
      },
    );
  }
}
