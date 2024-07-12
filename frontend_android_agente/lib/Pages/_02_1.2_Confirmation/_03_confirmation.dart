import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/APis/_02_report.dart';
import 'package:frontend_android/Widgets/Map_Global/map_global.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color lightBlueColor = Color(0xFF009DD4); // Azul Claro
const Color darkBlueColor = Color(0xFF010F56); // Azul Oscuro
const Color greyTextColor = Color(0xFF494A4D); // Gris (Texto)

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
      if (widget.latitude == null || widget.longitude == null) {
        throw Exception("Latitud y longitud son requeridas.");
      }

      double? latitude = double.tryParse(widget.latitude!);
      double? longitude = double.tryParse(widget.longitude!);

      if (latitude == null || longitude == null) {
        throw Exception(
            "Latitud y longitud deben ser números decimales válidos.");
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? reportedBy = prefs.getString('loggedInUser');

      if (reportedBy == null) {
        throw Exception("No se pudo obtener el usuario actual.");
      }

      Map<String, dynamic> reportData = {
        'licensePlate': widget.plateNumber,
        'registrationDocument':
            '123456789', // Asegúrate de tener el valor correcto
        'vehicleType': widget.vehicleType,
        'vehicleColor': widget.color,
        'model': 'Toyota', // Asegúrate de tener el valor correcto
        'year': '2020', // Asegúrate de tener el valor correcto
        'reference': widget.address,
        'lat': widget.latitude,
        'lon': widget.longitude,
        'reportedBy': reportedBy,
      };

      List<File> images =
          widget.imageFileList.map((xfile) => File(xfile.path)).toList();

      logger.i('Creating report with data: $reportData');
      logger.i('Images: ${images.length}');

      var response = await ApiServiceReport.createReport(reportData, images)
          .timeout(const Duration(seconds: 30));

      logger.i('Response status: ${response.statusCode}');
      logger.i('Response body: ${response.body}');
      if (!mounted) return;

      switch (response.statusCode) {
        case 201:
          Navigator.pushNamed(context, '/success');
          break;
        case 400:
          Navigator.pushNamed(
            context,
            '/error',
            arguments: {
              'errorMessage':
                  'Datos inválidos. Por favor, verifique los detalles e intente nuevamente.'
            },
          );
          break;
        case 409:
          Navigator.pushNamed(
            context,
            '/error',
            arguments: {
              'errorMessage':
                  'Ya existe un reporte activo para esta placa que no está liberado.'
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
      backgroundColor: const Color(0xFFFFFFFF), // Fondo blanco
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
                          color: lightBlueColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                SizedBox(
                  child: Center(
                    child: Text(
                      'Datos del vehículo',
                      style: TextStyle(
                        fontSize: 14.h,
                        fontWeight: FontWeight.bold,
                        color: greyTextColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  'Numero de placa',
                  style: TextStyle(
                    color: const Color(0xFF010F56),
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
                  'Marca',
                  style: TextStyle(
                    color: const Color(0xFF010F56),
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
                    color: const Color(0xFF010F56),
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
                    color: const Color(0xFF010F56),
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
                const MapWidget(),
                SizedBox(height: 5.h),
                const Divider(),
                if (widget.latitude != null && widget.longitude != null)
                  Text(
                    'Fotos del vehículo',
                    style: TextStyle(
                      fontSize: 11.h,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF010F56),
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
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 4.h),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _createReport,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            backgroundColor: const Color(0xFF010F56),
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
                            side: const BorderSide(color: darkBlueColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            'Cancelar',
                            style: TextStyle(
                              color: darkBlueColor,
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
      ),
    );
  }
}
