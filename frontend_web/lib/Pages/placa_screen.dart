import 'package:flutter/material.dart';
import 'package:web/Pages/report_screen.dart';
import 'dart:convert';
import '../models/citizen.dart';

class PlacaScreen extends StatelessWidget {
  final Citizen citizen;

  const PlacaScreen({super.key, required this.citizen});

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
        title: const Text(''),
        actions: [
          Row(
            children: [
              const Text('INFO'),
              IconButton(
                icon: const Icon(Icons.info),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReportScreen(
                        licensePlate: citizen.licensePlate,
                        address: citizen.registrationDocument,
                        status: citizen.status,
                        reportedDate: citizen.reportedDate,
                        towedByCraneDate: citizen.towedByCraneDate ?? '',
                        currentAddress: citizen.model,
                        arrivalAtParkinglot: citizen.arrivalAtParkinglot ?? '',
                        releaseDate: citizen.releaseDate ?? '',
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
            const Center(
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
                  backgroundColor: _getButtonColor(citizen.status),
                ),
                child: Text(
                  citizen.status,
                  style: const TextStyle(color: Colors.white),
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
                  _buildInfoRow('Número de Placa', citizen.licensePlate),
                  const Divider(height: 50),
                  _buildInfoRow('Tipo de Vehículo', citizen.vehicleType),
                  const Divider(height: 50),
                  _buildInfoRow('Color', citizen.vehicleColor),
                  const Divider(height: 50),
                  _buildInfoRow('Ubicación de la Retención',
                      citizen.registrationDocument),
                  const Divider(height: 50),
                  if (citizen.photos.isNotEmpty) ...[
                    const Text(
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
                      children: citizen.photos.map((photo) {
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
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF010F56),
          ),
        ),
        Text(value, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
