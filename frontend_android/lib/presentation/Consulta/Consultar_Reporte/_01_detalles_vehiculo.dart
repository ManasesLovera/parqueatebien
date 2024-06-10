import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:frontend_android/presentation/Consulta/Consultar_Reporte/_02_detallereporte.dart';

class VehicleDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> vehicleData;
  const VehicleDetailsScreen({super.key, required this.vehicleData});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'reportado':
        return Colors.grey;
      case 'retenido':
        return Colors.red;
      case 'liberado':
        return Colors.green;
      case 'incautado por grua':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('VehicleDetailsScreen: Received data: $vehicleData');

    List<Map<String, String>> photos = [];
    if (vehicleData['Photos'] is List) {
      photos = List<Map<String, String>>.from(
          vehicleData['Photos'].map((item) => Map<String, String>.from(item)));
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/whiteback/main_w.png',
                        height: 50.h,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      child: IconButton(
                        icon: const Icon(Icons.info_outline),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ReportInfoScreen(vehicleData: vehicleData),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Center(
                  child: Text(
                    'Datos del vehículo',
                    style: TextStyle(
                      fontSize: 20.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Center(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: _getStatusColor(
                          vehicleData['Status'] ?? 'Desconocido'),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      vehicleData['Status'] ?? 'Desconocido',
                      style: TextStyle(
                        fontSize: 16.h,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                _buildDetailItem(
                  title: 'Número de placa',
                  content: vehicleData['LicensePlate'] ?? 'Desconocido',
                ),
                _buildDetailItem(
                  title: 'Tipo de vehículo',
                  content: vehicleData['VehicleType'] ?? 'Desconocido',
                ),
                _buildDetailItem(
                  title: 'Color',
                  content: vehicleData['VehicleColor'] ?? 'Desconocido',
                ),
                _buildDetailItem(
                  title: 'Ubicación de la retención',
                  content: vehicleData['CurrentAddress'] ?? 'Desconocido',
                ),
                SizedBox(height: 2.h),
                Text(
                  'Fotos del vehículo',
                  style: TextStyle(
                    fontSize: 16.h,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  height: 100.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: photos.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.h),
                        child: Image.memory(
                          base64Decode(photos[index]['File']!),
                          width: 100.w,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem({required String title, required String content}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.h,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            content,
            style: TextStyle(
              fontSize: 14.h,
              color: Colors.black,
            ),
          ),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
