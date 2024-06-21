import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Views/Welcome/_01_consulta_.dart';
import 'package:frontend_android_ciudadano/Widgets/Welcome/_00_main_image.dart';
import 'package:frontend_android_ciudadano/Widgets/Welcome/_01_welcometext.dart';
import 'package:frontend_android_ciudadano/Widgets/Welcome/_02_subtituloreport.dart';
import 'package:frontend_android_ciudadano/Widgets/Welcome/_04_report_buttom.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.h),
        child: Column(
          children: [
            SizedBox(height: 30.h),
            const ImageReportConsult(),
            SizedBox(height: 35.h),
            const WelcomeText(),
            SizedBox(height: 10.h),
            const SubtituloReport(),
            SizedBox(height: 18.h),
            ReportConsultButtom(
              svgPath: 'assets/icons/car.svg',
              title: 'Consulta de vehiculo',
              subtitle: 'Consulta si tu vehiculo ha sido incautado',
              onTap: () {
                showVehicleDialog(context);
              },
            ),
            ReportConsultButtom(
              svgPath: 'assets/icons/create.svg',
              title: 'Agregar otro vehiculo',
              subtitle:
                  'Si posees otro vehiculo, añade los datos para futuras consultas',
              onTap: () {},
            ),
            ReportConsultButtom(
              svgPath: 'assets/icons/create.svg',
              title: 'Chat de soporte',
              subtitle:
                  'Obten asistencia inmediata a traves de nuestro chat de soporte',
              onTap: () {},
            ),
          ],
        ),
      )),
    );
  }
}
