import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Pages/_02_2_Consulta/_02_report_info.dart';

Widget buildResultHeader(
    BuildContext context, Map<String, dynamic> vehicleData) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Center(
        child: Text(
          'Resultado de consulta',
          style: TextStyle(
            fontSize: 16.h,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
      Positioned(
        left: 0,
        child: IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ReportInfoScreen(
                  vehicleData: vehicleData,
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

Widget buildVehicleTitle() {
  return Center(
    child: Text(
      'Datos del vehículo',
      style: TextStyle(
        fontSize: 16.h,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
    ),
  );
}

Widget buildStatus(Map<String, dynamic> vehicleData) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
    child: Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: getStatusColor(vehicleData['status'] ?? 'Desconocido'),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          vehicleData['status'] ?? 'Desconocido',
          style: TextStyle(
            fontSize: 12.h,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

Color getStatusColor(String status) {
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

Widget buildDetailRow(String title, String? value) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 11.h,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value ?? 'Desconocido',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 10.h,
            fontWeight: FontWeight.bold,
          ),
        ),
        Divider(height: 10.h),
      ],
    ),
  );
}

Widget buildPhotoGallery(List<Map<String, String>> photos) {
  return SizedBox(
    height: 65.h,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.memory(
              base64Decode(photos[index]['file']!),
              height: 55.h,
              width: 70.h,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    ),
  );
}
