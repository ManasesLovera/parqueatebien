import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildHeader(BuildContext context) {
  return Center(
    child: Stack(
      alignment: Alignment.centerLeft,
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
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    ),
  );
}

Widget buildTitle() {
  return Center(
    child: Text(
      'Informacion del reporte',
      style: TextStyle(
        fontSize: 16.h,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    ),
  );
}

Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'reportado':
      return Colors.grey;
    case 'incautado por grua':
      return Colors.orange;
    case 'retenido':
      return Colors.red;
    case 'liberado':
      return Colors.green;
    default:
      return Colors.grey;
  }
}

Widget buildStatus(Map<String, dynamic> vehicleData) {
  return Column(
    children: [
      SizedBox(
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'Status',
            style: TextStyle(
              fontSize: 12.h,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.w),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 2.h),
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
      ),
    ],
  );
}

Widget buildDetailItem({required String title, required String content}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 4.w),
    child: Center(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.h,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            content,
            style: TextStyle(
              fontSize: 12.h,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

Widget buildFooterMessage() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 4.w),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(10.h),
      child: Text(
        'Puede liberar su vehículo visitando el Centro de retención de vehículos del programa “Parquéate Bien” ubicado en la avenida Tiradentes #17, sector Naco, en horarios de 8:00AM a 7:00PM',
        style: TextStyle(
          fontSize: 12.h,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
