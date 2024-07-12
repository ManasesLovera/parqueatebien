import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/APis/_04_status_update.dart';
import 'package:frontend_android/Handlers/Detalles_De_Vehiculo_Update_Status/dialog_handler_update_status_.dart';
import 'package:frontend_android/Widgets/Consulta/vehicle_details_widgets.dart';
import 'package:frontend_android/Widgets/Map_Global/map_global.dart';

const Color lightBlueColor = Color(0xFF009DD4); // Azul Claro
const Color darkBlueColor = Color(0xFF010F56); // Azul Oscuro
const Color greyTextColor = Color(0xFF494A4D); // Gris (Texto)

class VehicleDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> vehicleData;
  final double lat;
  final double lon;

  const VehicleDetailsScreen({
    super.key,
    required this.vehicleData,
    required this.lat,
    required this.lon,
  });

  @override
  VehicleDetailsScreenState createState() => VehicleDetailsScreenState();
}

class VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  bool _isLoading = false;

  bool get _isButtonEnabled {
    return widget.vehicleData['status'].toString().toLowerCase() == 'reportado';
  }

  Future<void> _updateStatus(BuildContext context) async {
    if (_isButtonEnabled) {
      setState(() {
        _isLoading = true;
      });

      ChangeStatusDTO changeStatusDTO = ChangeStatusDTO(
        licensePlate: widget.vehicleData['licensePlate'],
        newStatus: 'Incautado por grua',
        username: 'your_username',
      );

      bool success =
          await ApiServiceUpdate.updateVehicleStatus(changeStatusDTO);
      if (!context.mounted) return;

      // Mostrar el modal de éxito o error
      showUniversalSuccessErrorDialogEstatus(
        context,
        success
            ? 'Estatus actualizado exitosamente'
            : 'Error al actualizar el estatus',
        success,
      );

      // Esperar a que el modal se cierre antes de proceder
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
          if (success) {
            widget.vehicleData['status'] = 'Incautado por grua';
          }
        });

        if (success) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => VehicleDetailsScreen(
                vehicleData: widget.vehicleData,
                lat: widget.lat,
                lon: widget.lon,
              ),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> photos = [];
    if (widget.vehicleData['photos'] is List) {
      photos = List<Map<String, String>>.from(widget.vehicleData['photos']
          .map((item) => Map<String, String>.from(item)));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // Fondo blanco
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                buildResultHeader(context, widget.vehicleData),
                SizedBox(height: 20.h),
                buildVehicleTitle(),
                buildStatus(widget.vehicleData),
                SizedBox(height: 20.h),
                DetailRowWidget(
                  title: 'Numero de placa',
                  value: widget.vehicleData['licensePlate'],
                  showDivider: true,
                ),
                DetailRowWidget(
                  title: 'Marca',
                  value: widget.vehicleData['vehicleType'],
                  showDivider: true,
                ),
                DetailRowWidget(
                  title: 'Color',
                  value: widget.vehicleData['vehicleColor'],
                  showDivider: true,
                ),
                DetailRowWidget(
                  title: 'Referencia',
                  value: widget.vehicleData['reference'],
                  showDivider: false,
                ),
                SizedBox(
                  child: MapWidget(
                    lat: widget.lat,
                    lon: widget.lon,
                  ),
                ),
                SizedBox(height: 10.h),
                const Divider(height: 10),
                SizedBox(height: 6.h),
                Text(
                  'Fotos del vehiculo',
                  style: TextStyle(
                    color: darkBlueColor,
                    fontSize: 9.h,
                  ),
                ),
                SizedBox(height: 6.h),
                buildPhotoGallery(photos),
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isButtonEnabled && !_isLoading
                        ? () => _updateStatus(context)
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      backgroundColor:
                          _isButtonEnabled ? darkBlueColor : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
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

class DetailRowWidget extends StatelessWidget {
  final String title;
  final String? value;
  final bool showDivider;

  const DetailRowWidget({
    super.key,
    required this.title,
    this.value,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF010F56),
              fontSize: 10.h,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value ?? 'Desconocido',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 9.h,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (showDivider) Divider(height: 2.h),
        ],
      ),
    );
  }
}
