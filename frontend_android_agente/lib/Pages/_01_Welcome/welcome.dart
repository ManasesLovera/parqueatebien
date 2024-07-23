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
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.warning,
                  color: Colors.orange,
                  size: 80,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Confirmación',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '¿Estás seguro que quieres cerrar sesión?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                    TextButton(
                      child: const Text(
                        'Salir',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        _logout(context); // Log out and navigate to login
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
