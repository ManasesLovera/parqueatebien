import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/APis/status_update.dart';
import 'package:frontend_android/Widgets/Reportes/_13_map.dart';
import 'package:frontend_android/Widgets/Consulta/vehicle_details_widgets.dart';

class VehicleDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> vehicleData;
  final double lat;
  final double lon;

  const VehicleDetailsScreen({
    super.key,
    required this.vehicleData,
    required this.lat,
    required this.lon,
  });

  bool get _isButtonEnabled {
    return vehicleData['status'].toString().toLowerCase() == 'reportado';
  }

  Future<void> _updateStatus(BuildContext context) async {
    if (_isButtonEnabled) {
      ChangeStatusDTO changeStatusDTO = ChangeStatusDTO(
        licensePlate: vehicleData['licensePlate'],
        newStatus: 'Incautado por grua',
        username: 'your_username',
      );

      bool success = await ApiServiceUpdate.updateVehicleStatus(changeStatusDTO);
      if (!context.mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Estatus actualizado exitosamente')),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => VehicleDetailsScreen(
              vehicleData: {...vehicleData, 'status': 'Incautado por grua'},
              lat: lat,
              lon: lon,
            ),
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
    List<Map<String, String>> photos = [];
    if (vehicleData['photos'] is List) {
      photos = List<Map<String, String>>.from(
          vehicleData['photos'].map((item) => Map<String, String>.from(item)));
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
                buildResultHeader(context, vehicleData),
                SizedBox(height: 20.h),
                buildVehicleTitle(),
                buildStatus(vehicleData),
                SizedBox(height: 20.h),
                buildDetailRow('Numero de placa', vehicleData['licensePlate']),
                buildDetailRow('Tipo de vehículo', vehicleData['vehicleType']),
                buildDetailRow('Color', vehicleData['vehicleColor']),
                buildDetailRow('Referencia', vehicleData['reference']),
                SizedBox(height: 4.h),
                buildPhotoGallery(photos),
                SizedBox(height: 10.h),
                Center(
                  child: SizedBox(
                    height: 125.h,
                    child: MapWidget(
                      lat: lat,
                      lon: lon,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        _isButtonEnabled ? () => _updateStatus(context) : null,
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
