import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';

class VehicleDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> vehicleData;

  const VehicleDetailsScreen({super.key, required this.vehicleData});

  @override
  Widget build(BuildContext context) {
    debugPrint('VehicleDetailsScreen: Received data: $vehicleData');

    List<Map<String, String>> photos = [];
    if (vehicleData['Photos'] is List) {
      photos = List<Map<String, String>>.from(
          vehicleData['Photos'].map((item) => Map<String, String>.from(item)));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: const Text('Vehicle Details'), // Simple title for now
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
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
                _buildDetailItem(
                  title: 'Fecha de reporte',
                  content: vehicleData['ReportedDate'] ?? 'Desconocido',
                ),
                _buildDetailItem(
                  title: 'Fecha de remolque por grúa',
                  content: vehicleData['TowedByCraneDate'] ?? 'Desconocido',
                ),
                _buildDetailItem(
                  title: 'Fecha de llegada al estacionamiento',
                  content: vehicleData['ArrivalAtParkinglot'] ?? 'Desconocido',
                ),
                _buildDetailItem(
                  title: 'Fecha de liberación',
                  content: vehicleData['ReleaseDate'] ?? 'Desconocido',
                ),
                _buildDetailItem(
                  title: 'Latitud',
                  content: vehicleData['Lat'] ?? 'Desconocido',
                ),
                _buildDetailItem(
                  title: 'Longitud',
                  content: vehicleData['Lon'] ?? 'Desconocido',
                ),
                SizedBox(height: 20.h),
                Text(
                  'Fotos del vehículo',
                  style: TextStyle(
                    fontSize: 16.h,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 10.h),
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
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem({required String title, required String content}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        padding: EdgeInsets.all(10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14.h,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 14.h,
                  color: Colors.black,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
