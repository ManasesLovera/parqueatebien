import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Widgets/Consulta/report_info_widgets.dart';
class ReportInfoScreen extends StatelessWidget {
  final Map<String, dynamic> vehicleData; // Datos del vehículo.

  const ReportInfoScreen({super.key, required this.vehicleData});

  @override
  Widget build(BuildContext context) {
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
                buildHeader(context), // Construye el encabezado.
                SizedBox(height: 40.h), // Espacio vertical.
                buildTitle(), // Construye el título.
                SizedBox(height: 20.h), // Espacio vertical.
                buildStatus(vehicleData), // Construye el estado del vehículo.
                SizedBox(height: 15.h), // Espacio vertical.
                buildDetailItem(
                  title: 'Fecha y hora de incautación por grúa:',
                  content: vehicleData['reportedDate'] ??
                      'Desconocido', // Muestra la fecha y hora de incautación o 'Desconocido' si es nulo.
                ),
                SizedBox(height: 7.h), // Espacio vertical.
                buildDetailItem(
                  title: 'Ubicación actual',
                  content: vehicleData['reference'] ??
                      'Desconocido', // Muestra la ubicación actual o 'Desconocido' si es nulo.
                ),
                SizedBox(height: 7.h), // Espacio vertical.
                buildDetailItem(
                  title: 'Fecha y hora de llegada al centro',
                  content: vehicleData['arrivalAtParkinglot'] ??
                      'Desconocido', // Muestra la fecha y hora de llegada al centro o 'Desconocido' si es nulo.
                ),
                SizedBox(height: 50.h), // Espacio vertical.
                buildFooterMessage(), // Construye el mensaje de pie de página.
              ],
            ),
          ),
        ),
      ),
    );
  }
}
