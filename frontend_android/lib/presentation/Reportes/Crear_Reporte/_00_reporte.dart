import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeNewReport extends StatelessWidget {
  const WelcomeNewReport({super.key});

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
              Image.asset(
                'assets/whiteback/main_w.png',
                height: 50.h,
              ),
              SizedBox(height: 50.h),
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
              ReportButton(
                svgPath: 'assets/icons/create.svg',
                title: 'Crear reporte',
                subtitle:
                    'Crea un nuevo reporte de un vehículo mal estacionado.',
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/NewReport');
                },
              ),
              SizedBox(height: 12.h),
              ReportButton(
                svgPath: 'assets/icons/car.svg',
                title: 'Consultar placa',
                subtitle:
                    'Consulta el estatus y ubicación de un vehículo incautado.',
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/consult');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReportButton extends StatelessWidget {
  final String svgPath;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ReportButton({
    super.key,
    required this.svgPath,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Container(
          padding: EdgeInsets.all(8.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2.h),
            borderRadius: BorderRadius.circular(12.h),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(svgPath, height: 35.h),
              SizedBox(width: 8.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.h,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 9.h,
                        color: Colors.grey[600],
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
