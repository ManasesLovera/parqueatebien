import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/UI/Views/DatosVehiculoStatus/_00_consulta_.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/GlobalsWidgets/_00_logo_image.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/Welcome/_01_welcometext.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/Welcome/_02_subtituloreport.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/Welcome/_04_report_buttom.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  Future<String?> _getGovernmentId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('governmentId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.h),
          child: Column(
            children: [
              SizedBox(height: 30.h),
              const CustomImageLogo(
                  img: 'assets/whiteback/main_w.png', altura: 60),
              SizedBox(height: 35.h),
              const WelcomeText(),
              SizedBox(height: 5.h),
              const SubtituloReport(sub: '¿Que deseas realizar hoy?'),
              SizedBox(height: 18.h),
              FutureBuilder<String?>(
                future: _getGovernmentId(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return const Text('Error al obtener el ID del usuario');
                  } else {
                    final governmentId = snapshot.data!;
                    return ReportConsultButtom(
                      svgPath: 'assets/icons/car.svg',
                      title: 'Consulta de vehiculo',
                      subtitle: 'Consulta si tu vehiculo ha sido incautado',
                      onTap: () {
                        showVehicleDialog(context, governmentId);
                      },
                    );
                  }
                },
              ),
              ReportConsultButtom(
                svgPath: 'assets/icons/create.svg',
                title: 'Agregar otro vehiculo',
                subtitle:
                    'Si posees otro vehiculo, añade los datos para futuras consultas',
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(builder: (context) => RegisterCar()),
                  // );
                },
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
      ),
    );
  }
}
