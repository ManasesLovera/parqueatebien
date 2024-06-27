import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Services/_02_Reporte/widgets/_13_map_consulta.dart';
import 'package:frontend_android/Services/update_status/_api_updatestatus.dart';
import 'dart:convert';

import 'package:frontend_android/views/_03_Consulta/_02_report_info.dart';

class VehicleDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> vehicleData;
  const VehicleDetailsScreen({super.key, required this.vehicleData});

  @override
  VehicleDetailsScreenState createState() => VehicleDetailsScreenState();
}

class VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  bool get _isButtonEnabled {
    return widget.vehicleData['Status'].toString().toLowerCase() == 'reportado';
  }

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

  Future<void> _updateStatus() async {
    if (widget.vehicleData['Status'].toString().toLowerCase() == 'reportado') {
      ChangeStatusDTO changeStatusDTO = ChangeStatusDTO(
        licensePlate: widget.vehicleData['LicensePlate'],
        newStatus: 'Incautado por grua',
        username: 'your_username',
      );

      bool success = await ApiService.updateVehicleStatus(changeStatusDTO);
      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Estatus actualizado exitosamente')),
        );
        setState(() {
          widget.vehicleData['Status'] = 'Incautado por grua';
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                VehicleDetailsScreen(vehicleData: widget.vehicleData),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al actualizar el estatus')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('VehicleDetailsScreen: Received data: ${widget.vehicleData}');

    List<Map<String, String>> photos = [];
    if (widget.vehicleData['Photos'] is List) {
      photos = List<Map<String, String>>.from(widget.vehicleData['Photos']
          .map((item) => Map<String, String>.from(item)));
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
                                  vehicleData: widget.vehicleData),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
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
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: _getStatusColor(
                            widget.vehicleData['Status'] ?? 'Desconocido'),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        widget.vehicleData['Status'] ?? 'Desconocido',
                        style: TextStyle(
                          fontSize: 12.h,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Numero de placa',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 11.h,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.vehicleData['LicensePlate'] ?? 'Desconocido',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10.h,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  height: 10.h,
                ),
                Text(
                  'Tipo de vehículo',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 11.h,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.vehicleData['VehicleType'] ?? 'Desconocido',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10.h,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  height: 10.h,
                ),
                Text(
                  'Color',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 11.h,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.vehicleData['VehicleColor'] ?? 'Desconocido',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10.h,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                //     widget.vehicleData['CurrentAddress'] ?? 'Desconocido',
                Text(
                  'Referencia',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 11.h,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.vehicleData['CurrentAddress'] ?? 'Desconocido',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10.h,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const MapWidgetConsulta(),
                SizedBox(height: 8.h),
                const Divider(),
                SizedBox(height: 4.h),
                SizedBox(
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
                              base64Decode(photos[index]['File']!),
                              height: 55.h,
                              width: 70.h,
                              fit: BoxFit.cover,
                            ),
                          ));
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isButtonEnabled ? _updateStatus : null,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      backgroundColor:
                          _isButtonEnabled ? Colors.blue : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Confirmar incautacion',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.h,
                        fontWeight: FontWeight.bold,
                      ),
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
}
