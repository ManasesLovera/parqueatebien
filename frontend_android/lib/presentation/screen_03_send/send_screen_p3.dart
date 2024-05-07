import 'package:frontend_android/send_data/get_to_submit_data.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend_android/location/location_service/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

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

// Location
  Future<void> _getCurrentLocation() async {
    Position? position = await locationService.getCurrentLocation();
    if (mounted) {
      if (position != null) {
        _logger.e('Localizacion Fue Obetenida con exito');
        setState(() {
          _currentPosition = position;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Localización obtenida exitosamente'),
            duration: Duration(seconds: 2), // Adjust the duration as needed
          ),
        );
      } else {
        _logger.e('Failed to retrieve current location');
        _showLocationErrorDialog();
      }
    }
  }

  void _showLocationErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error de Localización"),
        content: const Text("NO SE PUDO OBTENER LA LOCALIZACION.\n\n"
            "Ubicación Y WIFI !!!\n"
            "DEBEN ESTAR ACTIVADOS\n"
            "PARA ENVIAR LOS DATOS Y OBTENER LA LOCALIZACION\n"),
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

  Future<void> _submitData() async {
    try {
      await submitData(
        context: context,
        licensePlateController: _licensePlateController,
        descriptionController: _descriptionController,
        currentPosition: _currentPosition!,
        imageFile: widget.imageFile,
        showDialog: _showMessage,
      );
    } catch (e) {
      _showMessage('Error');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
