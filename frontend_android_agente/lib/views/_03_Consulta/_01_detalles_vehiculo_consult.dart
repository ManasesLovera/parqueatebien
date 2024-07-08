import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Services/add_licence/_api_.dart';
import 'package:frontend_android/Services/update_status/change_status_dto.dart';
import 'package:frontend_android/views/_03_Consulta/_02_report_info.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VehicleDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> vehicleData;

  const VehicleDetailsScreen({super.key, required this.vehicleData});

  @override
  VehicleDetailsScreenState createState() => VehicleDetailsScreenState();
}

class VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  final Logger _logger = Logger();
  bool _isLoading = false;

  bool get _isButtonEnabled {
    return (widget.vehicleData['status']?.toString().toLowerCase() ?? '') ==
        'reportado';
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
    setState(() {
      _isLoading = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? username = prefs.getString('username');

      if (username == null) {
        throw Exception("No se pudo obtener el usuario actual.");
      }

      String? status = widget.vehicleData['status']?.toString().toLowerCase();
      if (status == 'reportado') {
        ChangeStatusDTO changeStatusDTO = ChangeStatusDTO(
          licensePlate: widget.vehicleData['licensePlate'],
          newStatus: 'Incautado por grua',
          username: username,
        );

        bool success = await ApiService.updateVehicleStatus(changeStatusDTO);
        if (!mounted) return;

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Estatus actualizado exitosamente')),
          );
          setState(() {
            widget.vehicleData['status'] = 'Incautado por grua';
            _isLoading = false;
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
    } catch (e) {
      _logger.e('Failed to update status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar el estatus: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('VehicleDetailsScreen: Received data: ${widget.vehicleData}');

    List<Map<String, String>> photos = [];
    if (widget.vehicleData['photos'] is List) {
      photos = List<Map<String, String>>.from(widget.vehicleData['photos']
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
                            widget.vehicleData['status'] ?? 'Desconocido'),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        widget.vehicleData['status'] ?? 'Desconocido',
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
                  widget.vehicleData['licensePlate'] ?? 'Desconocido',
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
                  widget.vehicleData['vehicleType'] ?? 'Desconocido',
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
                  widget.vehicleData['vehicleColor'] ?? 'Desconocido',
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
                  widget.vehicleData['reference'] ?? 'Desconocido',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10.h,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                              base64Decode(photos[index]['file']!),
                              height: 55.h,
                              width: 70.h,
                              fit: BoxFit.cover,
                            ),
                          ));
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : SizedBox(
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
