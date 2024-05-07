import 'package:frontend_android/send_data/get_to_submit_data.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend_android/location/location_service/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

// Use logger FrameWork
final Logger _logger = Logger();

class SendData extends StatefulWidget {
  final File imageFile;
  final String mimeType;
  const SendData({super.key, required this.imageFile, required this.mimeType});

  @override
  SendDataState createState() => SendDataState();
}

class SendDataState extends State<SendData> {
  final LocationService locationService = LocationService();
  Position? _currentPosition;
  final TextEditingController _licensePlateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _licensePlateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enviar Datos'),
      ),
      // Hice la pantalla scroleable para evitar overflows
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _licensePlateController,
                // Limit Matricula to 7 Like DR matricula
                maxLength: 7,
                decoration: const InputDecoration(
                  labelText: 'Matricula',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descripcion',
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.file(widget.imageFile),
              ),
            ),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: const Text('Capture Geolocation'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_currentPosition != null &&
                        _licensePlateController.text.isNotEmpty &&
                        _licensePlateController.text.length == 7 &&
                        _descriptionController.text.isNotEmpty) {
                      _submitData();
                    } else {
                      _logger.e('Error Fatal ! , Enviar Datos');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Matricula Debe De Tener 7 Caracteres'
                              '\nincluyendo la localización'
                              '\nDATOS IMCOMPLETOS'),
                          duration: Duration(seconds: 4),
                        ),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
            if (_currentPosition != null)
              ListTile(
                title: Text('Latitude: ${_currentPosition!.latitude}'),
                subtitle: Text('Longitude: ${_currentPosition!.longitude}'),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitData() async {
    await submitData(
      context: context,
      licensePlateController: _licensePlateController,
      descriptionController: _descriptionController,
      currentPosition: _currentPosition!,
      imageFile: widget.imageFile,
    );
  }

// Location
  Future<void> _getCurrentLocation() async {
    Position? position = await locationService.getCurrentLocation();
    if (position != null) {
      setState(() {
        _currentPosition = position;
      });
    } else {
      _logger.e('Failed to retrieve current location');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error de Localización"),
          content: const Text(
              "No se pudo obtener la localización.\nAsegúrese de que la ubicación esté activada."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
