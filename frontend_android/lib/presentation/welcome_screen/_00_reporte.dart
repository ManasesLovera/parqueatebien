import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/componentes_visuales/report_buttons/report_button.dart';

class WelcomeNewReport extends StatelessWidget {
  const WelcomeNewReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50.h),
                  Image.asset(
                    'assets/main_w.png',
                    height: 100.h,
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Bienvenido',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 24.h,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Que deseas realizar hoy ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.h,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  ReportButton(
                    icon: Icons.add,
                    title: 'Crear reporte',
                    subtitle:
                        'Crea un nuevo reporte de un vehículo mal estacionado.',
                    onTap: () {
                      // Handle button tap here
                      //   print('Crear reporte tapped');
                    },
                  ),
                  SizedBox(height: 10.h),
                  ReportButton(
                    icon: Icons.car_repair,
                    title: 'Consultar placa',
                    subtitle:
                        'Consulta el estatus y ubicación de un vehículo incautado.',
                    onTap: () {
                      // Handle button tap here
                      //   print('Consultar placa tapped');
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }
}
