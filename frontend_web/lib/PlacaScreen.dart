import 'package:flutter/material.dart';
import 'package:web/main.dart';
import 'dart:convert';
// import 'photo.dart' as Photos; // Importa la clase Photo

class PlacaScreen extends StatelessWidget {
  final String licensePlate;
  final String vehicleType;
  final String address;
  final String vehicleColor;
  final String status;
  final String lat;
  final String lon;
  final List<Photo> photos;

  PlacaScreen({
    required this.licensePlate,
    required this.vehicleType,
    required this.address,
    required this.vehicleColor,
    required this.status,
    required this.lat,
    required this.lon,
    required this.photos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información de la Placa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/image/LOGO_PARQUEATE.png',
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Text(
                'Datos del Vehículo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Número de Placa:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF010F56),
              ),
            ),
            Text(licensePlate, style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8.0),
            Text(
              'Tipo de Vehículo:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF010F56),
              ),
            ),
            Text(vehicleType, style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8.0),
            Text(
              'Color del Vehículo:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF010F56),
              ),
            ),
            Text(vehicleColor, style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8.0),
            Text(
              'Ubicación de la Retención:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF010F56),
              ),
            ),
            Text(address, style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8.0),
            if (photos.isNotEmpty) ...[
              Text(
                'Fotos del Vehículo:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF010F56),
                ),
              ),
              const SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: photos.map((photo) {
                  return SizedBox(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Image.memory(
                        base64Decode(photo.file),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 8.0),
            Text(
              'Estado del Vehículo:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF010F56),
              ),
            ),
            Text(status, style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8.0),
            Text(
              'Latitud:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF010F56),
              ),
            ),
            Text(lat, style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8.0),
            Text(
              'Longitud:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF010F56),
              ),
            ),
            Text(lon, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}