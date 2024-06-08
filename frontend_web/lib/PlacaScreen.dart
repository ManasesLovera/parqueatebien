import 'package:flutter/material.dart';
import 'dart:convert';
import 'ReportScreen.dart';

class PlacaScreen extends StatelessWidget {
 final String licensePlate;
 final String vehicleType;
 final String vehicleColor;
 final String address;
 final String status;
 final String currentAddress;
 final String reportedDate;
 final String towedByCraneDate;
 final String arrivalAtParkinglot;
 final String releaseDate;
 final String lat;
 final String lon;
 final List photos;

  PlacaScreen({
    required this.licensePlate,
    required this.vehicleType,
    required this.vehicleColor,
    required this.address,
    required this.status,
    required this.currentAddress,
    required this.reportedDate,
    required this.towedByCraneDate,
    required this.arrivalAtParkinglot,
    required this.releaseDate,
    required this.lat,
    required this.lon,
    required this.photos,
  });

  Color _getButtonColor(String status) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          Row(
            children: [
              Text('INFO'),
              IconButton(
                icon: Icon(Icons.info),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReportScreen(
                        licensePlate: licensePlate,
                        address: address,
                        status: status,
                        reportedDate: reportedDate,
                        towedByCraneDate: towedByCraneDate,
                        currentAddress: currentAddress,
                        arrivalAtParkinglot: arrivalAtParkinglot,
                        releaseDate: releaseDate,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
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
            const SizedBox(height: 5),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Acción del botón
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getButtonColor(
                      status), // Color del botón según el estado
                ),
                child: Text(
                  '$status',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildInfoRow('Número de Placa', licensePlate),
                  Divider(
                    height: 50,
                  ),
                  _buildInfoRow('Tipo de Vehículo', vehicleType),
                  Divider(
                    height: 50,
                  ),
                  _buildInfoRow('Color', vehicleColor),
                  Divider(
                    height: 50,
                  ),
                  _buildInfoRow('Ubicación de la Retención', address),
                  Divider(
                    height: 50,
                  ),
                  if (photos.isNotEmpty) ...[
                    Text(
                      'Fotos del Vehículo',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF010F56),
          ),
        ),
        Text(value, style: TextStyle(fontSize: 18)),
        const SizedBox(height: 8.0),
      ],
    );
  }
}