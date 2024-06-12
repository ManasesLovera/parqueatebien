import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Services/_api_.dart';

import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmationScreen extends StatefulWidget {
  final String plateNumber;
  final String vehicleType;
  final String color;
  final String address;
  final String? latitude;
  final String? longitude;
  final List<XFile> imageFileList;

  const ConfirmationScreen({
    super.key,
    required this.plateNumber,
    required this.vehicleType,
    required this.color,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.imageFileList,
  });

  @override
  ConfirmationScreenState createState() => ConfirmationScreenState();
}

var logger = Logger();

class ConfirmationScreenState extends State<ConfirmationScreen> {
  Future<void> _createReport() async {
    try {
      DateTime now = DateTime.now();
      String formattedDate =
          "${now.month}/${now.day}/${now.year} ${now.hour}:${now.minute} ${now.hour >= 12 ? 'PM' : 'AM'}";

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? reportedBy = prefs.getString('loggedInUser');

      if (reportedBy == null) {
        throw Exception("No se pudo obtener el usuario actual.");
      }

      Map<String, dynamic> reportData = {
        'licensePlate': widget.plateNumber,
        'vehicleType': widget.vehicleType,
        'vehicleColor': widget.color,
        'address': widget.address,
        'status': "Reportado",
        "reportedBy": reportedBy,
        'currentAddress': widget.address,
        'reportedDate': formattedDate,
        'lat': widget.latitude,
        'lon': widget.longitude,
      };

      List<File> images =
          widget.imageFileList.map((xfile) => File(xfile.path)).toList();

      logger.i('Creating report with data: $reportData');
      logger.i('Images: ${images.length}');

      var response = await ApiService.createReport(reportData, images)
          .timeout(const Duration(seconds: 30));

      logger.i('Response status: ${response.statusCode}');
      logger.i('Response body: ${response.body}');

      if (!mounted) return;

      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/success');
      } else {
        throw Exception('Failed to create report: ${response.body}');
      }
    } catch (e) {
      logger.e('Failed to create report: $e');
      if (!mounted) return;
      Navigator.pushNamed(context, '/error',
          arguments: {'errorMessage': e.toString()});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Center(
                  child: Text(
                    'Confirmación',
                    style: TextStyle(
                      fontSize: 24.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Center(
                  child: Text(
                    'Datos del vehículo',
                    style: TextStyle(
                      fontSize: 16.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                DetailItem(
                  title: 'Número de placa',
                  content: widget.plateNumber,
                ),
                DetailItem(
                  title: 'Tipo de vehículo',
                  content: widget.vehicleType,
                ),
                DetailItem(
                  title: 'Color',
                  content: widget.color,
                ),
                DetailItem(
                  title: 'Dirección',
                  content: widget.address,
                ),
                SizedBox(height: 20.h),
                if (widget.latitude != null && widget.longitude != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Datos Geográficos',
                        style: TextStyle(
                          fontSize: 16.h,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      DetailItem(
                        title: 'Latitud',
                        content: widget.latitude!,
                      ),
                      DetailItem(
                        title: 'Longitud',
                        content: widget.longitude!,
                      ),
                    ],
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
                    itemCount: widget.imageFileList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Image.file(
                          File(widget.imageFileList[index].path),
                          width: 100.w,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _createReport,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            'Crear reporte',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.h,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.blue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            'Cancelar',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16.h,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
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
}

class DetailItem extends StatelessWidget {
  final String title;
  final String content;

  const DetailItem({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
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
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
