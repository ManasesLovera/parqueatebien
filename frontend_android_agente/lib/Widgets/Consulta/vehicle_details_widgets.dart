import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Pages/_02_2_Consulta/_02_report_info.dart';

const Color lightBlueColor = Color(0xFF009DD4); // Azul Claro
const Color darkBlueColor = Color(0xFF010F56); // Azul Oscuro
const Color greyTextColor = Color(0xFF494A4D); // Gris (Texto)

// Construye el encabezado del resultado de la consulta.
Widget buildResultHeader(
    BuildContext context, Map<String, dynamic> vehicleData) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Center(
        child: Text(
          'Resultado de consulta',
          style: TextStyle(
            fontSize: 16.h,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFF26522),
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
                  vehicleData: vehicleData,
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

// Construye el título de la sección de datos del vehículo.
Widget buildVehicleTitle() {
  return Center(
    child: Text(
      'Datos del vehículo',
      style: TextStyle(
        fontSize: 16.h,
        fontWeight: FontWeight.bold,
        color: greyTextColor,
      ),
    ),
  );
}

// Construye el estado del vehículo.
Widget buildStatus(Map<String, dynamic> vehicleData) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
    child: Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: getStatusColor(vehicleData['status'] ?? 'Desconocido'),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          vehicleData['status'] ?? 'Desconocido',
          style: TextStyle(
            fontSize: 12.h,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

// Obtiene el color correspondiente al estatus del vehículo.
Color getStatusColor(String status) {
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
              color: Colors.grey,
              fontSize: 9.h, // Tamaño de fuente.
              fontWeight: FontWeight.bold,
            ),
          ),
          if (showDivider)
            Divider(
                height: 2.h), // Muestra el divisor si showDivider es verdadero.
        ],
      ),
    );
  }
}

// Construye la galería de fotos del vehículo.
Widget buildPhotoGallery(List<Map<String, String>> photos) {
  return SizedBox(
    height: 50.h,
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
              height: 45.h,
              width: 70.h,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    ),
  );
}
