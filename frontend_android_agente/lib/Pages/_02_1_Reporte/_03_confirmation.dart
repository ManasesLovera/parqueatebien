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
  final String plateNumber; // Número de placa del vehículo.
  final String vehicleType; // Tipo de vehículo.
  final String color; // Color del vehículo.
  final String address; // Dirección de referencia.
  final String? latitude; // Latitud de la ubicación del vehículo.
  final String? longitude; // Longitud de la ubicación del vehículo.
  final List<XFile> imageFileList; // Lista de imágenes del vehículo.

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

var logger = Logger(); // Instancia de Logger para el registro de logs.

class ConfirmationScreenState extends State<ConfirmationScreen> {
  // Método para crear un reporte.
  Future<void> _createReport() async {
    try {
      if (widget.latitude == null || widget.longitude == null) {
        throw Exception(
            "Latitud y longitud son requeridas."); // Verifica si la latitud y longitud son nulas.
      }

      double? latitude = double.tryParse(widget.latitude!);
      double? longitude = double.tryParse(widget.longitude!);

      if (latitude == null || longitude == null) {
        throw Exception(
            "Latitud y longitud deben ser números decimales válidos."); // Verifica si la latitud y longitud son válidas.
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? reportedBy = prefs.getString('loggedInUser');

      if (reportedBy == null) {
        throw Exception(
            "No se pudo obtener el usuario actual."); // Verifica si el usuario actual es nulo.
      }

      Map<String, dynamic> reportData = {
        'licensePlate': widget.plateNumber,
        'registrationDocument':
            '123456789', // Valor de ejemplo, asegúrate de tener el valor correcto.
        'vehicleType': widget.vehicleType,
        'vehicleColor': widget.color,
        'model':
            'Toyota', // Valor de ejemplo, asegúrate de tener el valor correcto.
        'year':
            '2020', // Valor de ejemplo, asegúrate de tener el valor correcto.
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

      // Manejo de respuesta del servidor basado en el código de estado.
      switch (response.statusCode) {
        case 201:
          Navigator.pushNamed(
              context, '/success'); // Navega a la pantalla de éxito.
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
      Navigator.pushNamed(context, '/error', arguments: {
        'errorMessage': e.toString()
      }); // Navega a la pantalla de error con el mensaje de excepción.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // Fondo blanco.
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h), // Espacio vertical.
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.h),
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        'Confirmación',
                        style: TextStyle(
                          fontSize: 20.h,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFF26522),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.h), // Espacio vertical.
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
                SizedBox(height: 30.h), // Espacio vertical.
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
                SizedBox(height: 3.h), // Espacio vertical.
                const MapWidget(), // Mapa con la ubicación del vehículo.
                SizedBox(height: 5.h), // Espacio vertical.
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
                SizedBox(height: 4.h), // Espacio vertical.
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
                SizedBox(height: 2.h), // Espacio vertical.
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 4.h),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              _createReport, // Método para crear el reporte.
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            backgroundColor: const Color(0xFFF26522),
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
                      SizedBox(height: 5.h), // Espacio vertical.
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                                context); // Regresa a la pantalla anterior.
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Color(0xFFF26522)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            'Cancelar',
                            style: TextStyle(
                              color: const Color(0xFFF26522),
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
