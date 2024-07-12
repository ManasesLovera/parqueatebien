import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Widgets/Welcome/_00_mainimage.dart';
import 'package:frontend_android/Widgets/Welcome/_01_welcometext.dart';
import 'package:frontend_android/Widgets/Welcome/_02_subtituloreport.dart';
import 'package:frontend_android/Widgets/Welcome/_03_reportorconsultbuttom.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all preferences
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

   Future<void> _showLogoutConfirmation(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: const Text('¿Estás seguro que quieres cerrar sesión?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Salir'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _logout(context); // Log out and navigate to login
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _showLogoutConfirmation(context);
        return false; // Prevents the screen from being removed automatically
      },
      child: Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // Fondo blanco
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.h),
                const ImageReportConsult(),
                SizedBox(height: 50.h),
                const WelcomeText(
                  role: '',
                ),
                SizedBox(height: 3.h),
                const SubtituloReport(),
                SizedBox(height: 30.h),
                ReportConsultButtom(
                  svgPath: 'assets/icons/create.svg',
                  title: 'Crear reporte',
                  subtitle:
                      'Crea un nuevo reporte de un vehículo mal estacionado.',
                  onTap: () {
                    Navigator.of(context).pushNamed('/report');
                  },
                ),
                SizedBox(height: 12.h),
                ReportConsultButtom(
                  svgPath: 'assets/icons/car.svg',
                  title: 'Consultar placa',
                  subtitle:
                      'Consulta el estatus y ubicación de un vehículo incautado.',
                  onTap: () {
                    Navigator.of(context).pushNamed('/consult');
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
