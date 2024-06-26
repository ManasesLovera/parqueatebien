import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';

class ReportInfoScreen extends StatelessWidget {
  final Map<String, dynamic> vehicleData;
  const ReportInfoScreen({super.key, required this.vehicleData});

  Color _getStatusColor(String status) {
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

  Future<String> _getAddressFromLatLng(double lat, double lon) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
    if (placemarks.isNotEmpty) {
      return '${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.country}';
    } else {
      return 'Dirección no encontrada';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Center(
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
                ),
                SizedBox(height: 40.h),
                Center(
                  child: Text(
                    'Informacion del reporte',
                    style: TextStyle(
                      fontSize: 16.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 60.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: _getStatusColor(
                            vehicleData['Status'] ?? 'Desconocido'),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        vehicleData['Status'] ?? 'Desconocido',
                        style: TextStyle(
                          fontSize: 12.h,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                _buildDetailItem(
                  title: 'Fecha y hora de incautación por grúa:',
                  content: vehicleData['ReportedDate'] ?? 'Desconocido',
                ),
                FutureBuilder(
                  future: _getAddressFromLatLng(
                      double.parse(vehicleData['Lat']),
                      double.parse(vehicleData['Lon'])),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _buildDetailItem(
                        title: 'Ubicación actual:',
                        content: 'Cargando dirección...',
                      );
                    } else if (snapshot.hasError) {
                      return _buildDetailItem(
                        title: 'Ubicación actual:',
                        content: 'Error al obtener la dirección',
                      );
                    } else {
                      return _buildDetailItem(
                        title: 'Ubicación actual:',
                        content: snapshot.data as String,
                      );
                    }
                  },
                ),
                _buildDetailItem(
                  title: 'Fecha y hora de llegada al centro:',
                  content: vehicleData['ArrivalAtParkinglot'] ?? 'Desconocido',
                ),
                SizedBox(height: 50.h),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.h, vertical: 4.w),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem({required String title, required String content}) {
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
}
