import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
 final String licensePlate;
 final String address;
 final String status;
 final String currentAddress;
 final String reportedDate;
 final String towedByCraneDate;
 final String arrivalAtParkinglot;
 final String releaseDate;

  ReportScreen({
    required this.licensePlate,
    required this.address,
    required this.status,
    required this.currentAddress,
    required this.reportedDate,
    required this.towedByCraneDate,
    required this.arrivalAtParkinglot,
    required this.releaseDate,
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
            const SizedBox(height: 5),
             Center(
              child: Text(
                'Infomacion del reporte',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF010F56)
                ),
              ),
            ), 
            const SizedBox(height: 50),
            Center(
              child: Text(
                'Status:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getButtonColor(status), // Color del botón según el estado
                ),
                child: Text(
                  '$status',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Column(
                children: [
                  _buildInfoRow('Fecha y Hora de Incautación', reportedDate),
                  
                  _buildInfoRow('Ubicación Actual', currentAddress),
                  _buildInfoRow('Fecha y Hora de Llegada al Centro', arrivalAtParkinglot),
                ],
              ),
            ),
            if (status.toLowerCase() == 'retenido') ...[
              const SizedBox(height: 250),
              Center(
                child: _buildTextBox('Instrucciones para Sacar el Vehículo', releaseDate),
              ),
            ],
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
          width: 400,
          constraints: BoxConstraints(
            minHeight: 150.0,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromARGB(255, 136, 155, 252)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            value,
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}