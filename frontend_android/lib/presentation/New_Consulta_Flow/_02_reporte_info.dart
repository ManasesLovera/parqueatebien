import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportInfoScreen extends StatelessWidget {
  const ReportInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Implement refresh functionality here
            },
          ),
        ],
        centerTitle: true,
        title: Image.asset(
          'assets/logo.png', // Replace with your logo asset path
          height: 40.h,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              Text(
                'Información del reporte',
                style: TextStyle(
                  fontSize: 20.h,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              _buildStatusInfo(),
              SizedBox(height: 20.h),
              _buildDetailItem(
                title: 'Fecha y hora de incautación por grúa:',
                content: '22/05/2024 - 3:30PM',
              ),
              _buildDetailItem(
                title: 'Ubicación actual:',
                content:
                    'El centro de retención de vehículos del programa “Parquéate Bien”.',
              ),
              _buildDetailItem(
                title: 'Fecha y hora de llegada al centro:',
                content: '22/05/2024 - 4:30PM',
              ),
              SizedBox(height: 20.h),
              _buildReleaseInstructions(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Estatus:',
          style: TextStyle(
            fontSize: 16.h,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20.h),
          ),
          child: Text(
            'Vehículo retenido',
            style: TextStyle(
              fontSize: 16.h,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem({required String title, required String content}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.h,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            content,
            style: TextStyle(
              fontSize: 16.h,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReleaseInstructions() {
    return Container(
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.h),
      ),
      child: Text(
        'Puede liberar su vehículo visitando el Centro de retención de vehículos del programa “Parquéate Bien” ubicado en la avenida Tiradentes #17, sector Naco, en horarios de 8:00AM a 7:00PM',
        style: TextStyle(
          fontSize: 16.h,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
