import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/config/Report_Buttons/report_button.dart';

class WelcomeNewReport extends StatelessWidget {
  const WelcomeNewReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h),
                  Image.asset(
                    'assets/whiteback/main_w.png',
                    height: 60.h,
                  ),
                  SizedBox(height: 40.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.h),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Bienvenido',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 26.h,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.h),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        '¿Que deseas realizar hoy?',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13.h,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  // Icon
                  ReportButton(
                    icon: Icons.add,
                    title: 'Crear reporte',
                    subtitle:
                        'Crea un nuevo reporte de un vehículo mal estacionado.',
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, '/NewReport');
                    },
                  ),
                  SizedBox(height: 10.h),
                  ReportButton(
                    icon: Icons.car_repair,
                    title: 'Consultar placa',
                    subtitle:
                        'Consulta el estatus y ubicación de un vehículo incautado.',
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, '/consult');
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }
}
