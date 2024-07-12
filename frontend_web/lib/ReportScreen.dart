// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:web/map.dart';

class ReportScreen extends StatelessWidget {
  final String registrationNumber;
  final String licensePlate;
  final String registrationDocument;
  final String vehicleType;
  final String vehicleColor;
  final String model;
  final String year;
  final String reference;
  final String status;
  final String reportedDate;
  final dynamic towedByCraneDate;
  final dynamic arrivalAtParkinglot;
  final dynamic releaseDate;
  final double lat;
  final double lon;
  final List<String> photos;

  ReportScreen({
    required this.registrationNumber,
    required this.licensePlate,
    required this.registrationDocument,
    required this.vehicleType,
    required this.vehicleColor,
    required this.model,
    required this.year,
    required this.reference,
    required this.status,
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0), 
              child: Center(
                child: Image.asset(
                  'assets/image/LOGO_PARQUEATE.png',
                  height: 75,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              height: 40,
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 243, 243, 243),
              ),
              child: Text(
                'DATOS DEL VEHÍCULO',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF010F56),
                ),
              ),
            ),
            const SizedBox(height:2),
            Center(
              child: Text('',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getButtonColor(status), 
                ),
                child: Text(
                  status,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Column(
                children: [
                  _buildInfoRow('Fecha y Hora de Incautación', reportedDate),
                  _buildInfoRow('Referencias', reference),
                  _buildInfoRow('Fecha y Hora de Llegada al Centro', arrivalAtParkinglot.toString()),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (status.toLowerCase() != 'liberado') ...[
              Center(
                child: _buildTextBox(
                  'Instrucciones para la recuperación de su vehículo',
                  'Puede liberar su vehículo visitando el Centro de Retención de Vehículos del programa "Parquéate Bien", ubicado en la Avenida Tiradentes #17, sector Naco, en horarios de 8:00 AM a 7:00 PM.',
                  
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'Ubicación de canodromo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF010F56),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: Container(
                  height: 150, 
                  width: 600,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF010F56)),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), 
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: MapWidget( 
                      destinationLat: lat,
                      destinationLon: lon,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         
        },
        child: Icon(Icons.chat),
        backgroundColor: Colors.blue,
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

  Widget _buildTextBox(String label, String value) {
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
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(20.0),
          width: 600,
          height: 75,
          constraints: BoxConstraints(
            minHeight: 150.0,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromARGB(255, 136, 155, 252)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}