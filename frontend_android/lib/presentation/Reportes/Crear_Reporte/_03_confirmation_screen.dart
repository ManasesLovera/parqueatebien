import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Services/add_licence/_api_.dart';

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

      switch (response.statusCode) {
        case 200:
          Navigator.pushNamed(context, '/success');
          break;
        case 400:
          Navigator.pushNamed(
            context,
            '/error',
            arguments: {
              'errorMessage':
                  'El reporte con esta información ya existe. Por favor, verifique los detalles e intente nuevamente.'
            },
          );
          break;
        case 500:
          Navigator.pushNamed(
            context,
            '/error',
            arguments: {
              'errorMessage':
                  'Ocurrió un error en el servidor. Por favor, inténtelo más tarde.'
            },
          );
          break;
        default:
          Navigator.pushNamed(
            context,
            '/error',
            arguments: {
              'errorMessage':
                  'Ocurrió un error inesperado: ${response.statusCode} - ${response.reasonPhrase}'
            },
          );
          break;
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.h),
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        'Confirmación',
                        style: TextStyle(
                          fontSize: 20.h,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.h),
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        'Datos del vehículo',
                        style: TextStyle(
                          fontSize: 14.h,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.h),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Numero de placa',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 14.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.h),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.plateNumber,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Divider(
                  height: 10.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                //
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.h),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tipo de vehiculo',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 14.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.h),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.vehicleType,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Divider(
                  height: 10.h,
                ),
                SizedBox(
                  height: 6.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.h),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Color',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 14.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.h),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.color,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Divider(
                  height: 10.h,
                ),
                SizedBox(
                  height: 6.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.h),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Direccion',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 14.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.h),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.address,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Divider(
                  height: 10.h,
                ),
                SizedBox(height: 10.h),
                if (widget.latitude != null && widget.longitude != null)
                  Text(
                    'Fotos del vehículo',
                    style: TextStyle(
                      fontSize: 14.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 65.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.imageFileList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.h),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.file(
                              File(widget.imageFileList[index].path),
                              width: 100.w,
                              fit: BoxFit.cover,
                            ),
                          ));
                    },
                  ),
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _createReport,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            backgroundColor: Colors.blueAccent,
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
                      SizedBox(height: 5.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
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
                //   SizedBox(height: 10.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
