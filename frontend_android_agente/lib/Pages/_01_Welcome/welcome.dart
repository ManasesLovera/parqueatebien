import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Widgets/Welcome/_00_mainimage.dart';
import 'package:frontend_android/Widgets/Welcome/_01_welcometext.dart';
import 'package:frontend_android/Widgets/Welcome/_02_subtituloreport.dart';
import 'package:frontend_android/Widgets/Welcome/_03_reportorconsultbuttom.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  // Método para cerrar sesión.
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Limpia todas las preferencias.
    if (context.mounted) {
      Navigator.of(context)
          .pushReplacementNamed('/login'); // Navega a la pantalla de login.
    }
  }

  // Método para mostrar la confirmación de cierre de sesión.
  Future<void> _showLogoutConfirmation(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Bordes redondeados.
          ),
          child: Padding(
            padding:
                const EdgeInsets.all(20.0), // Espaciado interno del diálogo.
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.warning,
                  color: Colors.orange,
                  size: 80, // Tamaño del icono de advertencia.
                ),
                const SizedBox(height: 20), // Espaciado vertical.
                const Text(
                  'Confirmación',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18, // Tamaño de fuente.
                    fontWeight: FontWeight.w600,
                    color: Colors.black87, // Color del texto.
                  ),
                ),
                const SizedBox(height: 10), // Espaciado vertical.
                const Text(
                  '¿Estás seguro que quieres cerrar sesión?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16, // Tamaño de fuente.
                    color: Colors.black54, // Color del texto.
                  ),
                ),
                const SizedBox(height: 20), // Espaciado vertical.
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, // Distribución de los botones.
                  children: [
                    TextButton(
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(
                            color: Colors
                                .blue), // Color del texto del botón cancelar.
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // Cierra el diálogo.
                      },
                    ),
                    TextButton(
                      child: const Text(
                        'Salir',
                        style: TextStyle(
                            color:
                                Colors.red), // Color del texto del botón salir.
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // Cierra el diálogo.
                        _logout(context); // Cierra sesión y navega al login.
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _showLogoutConfirmation(
            context); // Muestra la confirmación de cierre de sesión al intentar retroceder.
        return false; // Previene que la pantalla sea removida automáticamente.
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF), // Fondo blanco.
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 12.h), // Alineación horizontal.
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Alineación centrada.
              children: [
                SizedBox(height: 30.h), // Espacio vertical.
                const ImageReportConsult(), // Widget de la imagen principal.
                SizedBox(height: 50.h), // Espacio vertical.
                const WelcomeText(
                  role: '', // Texto de bienvenida.
                ),
                SizedBox(height: 3.h), // Espacio vertical.
                const SubtituloReport(), // Subtítulo del reporte.
                SizedBox(height: 30.h), // Espacio vertical.
                ReportConsultButtom(
                  svgPath: 'assets/icons/create.svg', // Ruta del icono.
                  title: 'Crear reporte', // Título del botón.
                  subtitle:
                      'Crea un nuevo reporte de un vehículo mal estacionado.', // Subtítulo del botón.
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        '/report'); // Navega a la pantalla de crear reporte.
                  },
                ),
                SizedBox(height: 12.h), // Espacio vertical.
                ReportConsultButtom(
                  svgPath: 'assets/icons/car.svg', // Ruta del icono.
                  title: 'Consultar placa', // Título del botón.
                  subtitle:
                      'Consulta el estatus y ubicación de un vehículo incautado.', // Subtítulo del botón.
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        '/consult'); // Navega a la pantalla de consultar placa.
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
