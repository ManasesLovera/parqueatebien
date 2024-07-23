import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/APis/_04_status_update.dart';
import 'package:frontend_android/Handlers/Detalles_De_Vehiculo_Update_Status/dialog_handler_update_status_.dart';
import 'package:frontend_android/Widgets/Consulta/vehicle_details_widgets.dart';
import 'package:frontend_android/Widgets/Map_Global/map_global.dart';

class VehicleDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> vehicleData; // Datos del vehículo.
  final double lat; // Latitud de la ubicación del vehículo.
  final double lon; // Longitud de la ubicación del vehículo.

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
  bool _isLoading = false; // Estado de carga.

  bool get _isButtonEnabled {
    return widget.vehicleData['status'].toString().toLowerCase() == 'reportado';
  }

  // Método para actualizar el estatus del vehículo.
  Future<void> _updateStatus(BuildContext context) async {
    if (_isButtonEnabled) {
      setState(() {
        _isLoading = true; // Activa el estado de carga.
      });

      ChangeStatusDTO changeStatusDTO = ChangeStatusDTO(
        licensePlate: widget.vehicleData['licensePlate'],
        newStatus: 'Incautado por grua',
        username:
            'your_username', // Debe reemplazarse con el nombre de usuario actual.
      );

      bool success =
          await ApiServiceUpdate.updateVehicleStatus(changeStatusDTO);
      if (!context.mounted) return;

      // Muestra el modal de éxito o error.
      showUniversalSuccessErrorDialogEstatus(
        context,
        success
            ? 'Estatus actualizado exitosamente'
            : 'Error al actualizar el estatus',
        success,
      );

      // Espera a que el modal se cierre antes de proceder.
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
      backgroundColor: const Color(0xFFFFFFFF), // Fondo blanco.
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 14.h), // Alineación horizontal.
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Alineación a la izquierda.
              children: [
                SizedBox(height: 20.h), // Espacio vertical.
                buildResultHeader(
                    context,
                    widget
                        .vehicleData), // Construye el encabezado del resultado.
                SizedBox(height: 20.h), // Espacio vertical.
                buildVehicleTitle(), // Construye el título del vehículo.
                buildStatus(
                    widget.vehicleData), // Construye el estado del vehículo.
                SizedBox(height: 20.h), // Espacio vertical.
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
                SizedBox(height: 10.h), // Espacio vertical.
                const Divider(height: 10),
                SizedBox(height: 6.h), // Espacio vertical.
                Text(
                  'Fotos del vehiculo',
                  style: TextStyle(
                    color: darkBlueColor,
                    fontSize: 9.h,
                  ),
                ),
                SizedBox(height: 6.h), // Espacio vertical.
                buildPhotoGallery(photos), // Construye la galería de fotos.
                SizedBox(height: 10.h), // Espacio vertical.
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isButtonEnabled && !_isLoading
                        ? () => _updateStatus(
                            context) // Método para actualizar el estatus del vehículo.
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      backgroundColor: _isButtonEnabled
                          ? const Color(0xFFF26522)
                          : Colors.grey,
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

// Widget personalizado para mostrar una fila de detalles.
class DetailRowWidget extends StatelessWidget {
  final String title; // Título de la fila de detalles.
  final String? value; // Valor de la fila de detalles.
  final bool showDivider; // Indica si se muestra el divisor.

  const DetailRowWidget({
    super.key,
    required this.title,
    this.value,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h), // Alineación inferior.
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Alineación a la izquierda.
        children: [
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF010F56),
              fontSize: 10.h, // Tamaño de fuente.
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value ??
                'Desconocido', // Muestra "Desconocido" si el valor es nulo.
            style: TextStyle(
              color: const Color(0xFF494A4D),
              fontSize: 10.h, // Tamaño de fuente.
              fontWeight: FontWeight.bold,
            ),
          ),
          if (showDivider)
            Divider(
                height: 6.h), // Muestra el divisor si showDivider es verdadero.
        ],
      ),
    );
  }
}
