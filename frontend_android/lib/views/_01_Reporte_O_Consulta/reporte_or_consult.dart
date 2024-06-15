import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Services/_01_Reporte_O_Consulta/Controllers/navigation_controller.dart';
import 'package:frontend_android/Services/_01_Reporte_O_Consulta/widgets/_03_reportorconsultbuttom.dart';
import 'package:frontend_android/Services/_01_Reporte_O_Consulta/widgets/_00_mainimage.dart';
import 'package:frontend_android/Services/_01_Reporte_O_Consulta/widgets/_02_subtituloreport.dart';
import 'package:frontend_android/Services/_01_Reporte_O_Consulta/widgets/_01_welcometext.dart';

class ReportorConsult extends StatelessWidget {
  const ReportorConsult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),
              const ImageReportConsult(),
              SizedBox(height: 50.h),
              const WelcomeText(),
              SizedBox(height: 3.h),
              const SubtituloReport(),
              SizedBox(height: 30.h),
              ReportConsultButtom(
                svgPath: 'assets/icons/create.svg',
                title: 'Crear reporte',
                subtitle:
                    'Crea un nuevo reporte de un vehículo mal estacionado.',
                onTap: () {
                  NavigationController.navigateToNewReport(context);
                },
              ),
              SizedBox(height: 12.h),
              ReportConsultButtom(
                svgPath: 'assets/icons/car.svg',
                title: 'Consultar placa',
                subtitle:
                    'Consulta el estatus y ubicación de un vehículo incautado.',
                onTap: () {
                  NavigationController.navigateToConsult(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
