import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Widgets/Consulta/report_info_widgets.dart';

class ReportInfoScreen extends StatelessWidget {
  final Map<String, dynamic> vehicleData;

  const ReportInfoScreen({super.key, required this.vehicleData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF), // Fondo blanco
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                buildHeader(context),
                SizedBox(height: 40.h),
                buildTitle(),
                SizedBox(height: 20.h),
                buildStatus(vehicleData),
                SizedBox(height: 15.h),
                buildDetailItem(
                  title: 'Fecha y hora de incautación por grúa:',
                  content: vehicleData['reportedDate'] ?? 'Desconocido',
                ),
                SizedBox(height: 7.h),
                buildDetailItem(
                  title: 'Ubicación actual',
                  content: vehicleData['reference'] ?? 'Desconocido',
                ),
                SizedBox(height: 7.h),
                buildDetailItem(
                  title: 'Fecha y hora de llegada al centro',
                  content: vehicleData['arrivalAtParkinglot'] ?? 'Desconocido',
                ),
                SizedBox(height: 50.h),
                buildFooterMessage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
