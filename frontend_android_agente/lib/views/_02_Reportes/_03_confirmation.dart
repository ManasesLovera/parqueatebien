import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Services/_02_Reporte/widgets/_13_map.dart';
import 'package:frontend_android/Services/_02_Reporte/widgets/_13_map_C.dart';
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
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h),
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
                  SizedBox(
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
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    'Numero de placa',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 11.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.plateNumber,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  Text(
                    'Tipo de vehiculo',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 11.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.vehicleType,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  Text(
                    'Color',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 11.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.color,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  Text(
                    'Referencia',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 11.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.address,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  const MapWidgetC(),
                  SizedBox(height: 5.h),
                  const Divider(),
                  if (widget.latitude != null && widget.longitude != null)
                    Text(
                      'Fotos del vehículo',
                      style: TextStyle(
                        fontSize: 11.h,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  SizedBox(height: 4.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: widget.imageFileList.map((file) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.file(
                              File(file.path),
                              height: 55.h,
                              width: 70.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
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
                                fontSize: 14.h,
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
                                fontSize: 14.h,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
