import 'dart:convert';
// import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend_android/location_service.dart';
import 'package:geolocator/geolocator.dart';

class SendData extends StatefulWidget {
  final File imageFile;
  // Cambios sugeridos Gracias
  final String mimeType;
  // Requerimos mimeType
  const SendData({super.key, required this.imageFile, required this.mimeType});

  @override
  _SendDataState createState() => _SendDataState();
}

class _SendDataState extends State<SendData> {
  final LocationService _locationService = LocationService();
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

  Future<void> _getCurrentLocation() async {
    Position? position = await _locationService.getCurrentLocation();
    if (position != null) {
      setState(() {
        _currentPosition = position;
      });
    } else {
      // Handle the case when the position is null
      // For example, display an error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error Localización'),
          content: const Text(
              'No se pudo Obtener la Localización !\nAsegurese que este encendida.!'),
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

  Future<void> _submitData() async {
    try {
      final licensePlate = _licensePlateController.text;
      final description = _descriptionController.text;
      final latitude = _currentPosition!.latitude;
      final longitude = _currentPosition!.longitude;
      final image = widget.imageFile;
      // final type = widget.mimeType;

      // dertermino si MIME type based on file extension
      String type = 'image/jpeg'; // Default MIME type
      if (image.path.endsWith('.png')) {
        type = 'image/png';
      } else if (image.path.endsWith('.gif')) {
        type = 'image/gif';
      }

      List<int> imageBytes = image.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);

      final response = await http.post(
      //  Uri.parse('http://192.168.0.236:8089/ciudadanos'),
       Uri.parse('http://localhost:8089/ciudadanos'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'licensePlate': licensePlate,
          'description': description,
          'lat': latitude,
          'lon': longitude,
          'file': base64Image,
          'fileType': type
        }),
      );

      if (response.statusCode == 200) {
        // Handle successful response
        print('Data submitted successfully');
      } else {
        // Handle error response
        print('Failed to submit data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions
      print('Error: $e');
    }
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
                  labelText: 'Description',
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
                  // Condicionamos que no esten en Mat,Desc and Geo
                  onPressed: () {
                    if (_currentPosition != null &&
                        _licensePlateController.text.isNotEmpty &&
                        _descriptionController.text.isNotEmpty) {
                      _submitData();
                    } else {
                      // Notificamos Si Mat,Desc and Geo no estan todos llenos
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Todos los campos deben estar llenos, incluyendo la localización'),
                          duration: Duration(seconds: 2),
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
            if (_currentPosition != null) // Display location if available
              ListTile(
                title: Text('Latitude: ${_currentPosition!.latitude}'),
                subtitle: Text('Longitude: ${_currentPosition!.longitude}'),
              ),
          ],
        ),
      ),
    );
  }
}
