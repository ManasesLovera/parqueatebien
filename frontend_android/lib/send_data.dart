import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend_android/location_service.dart';
import 'package:geolocator/geolocator.dart';

class SendData extends StatefulWidget {
  final File imageFile;

  const SendData({required this.imageFile});

  @override
  _SendDataState createState() => _SendDataState();
}

class _SendDataState extends State<SendData> {
  final LocationService _locationService = LocationService();
  Position? _currentPosition;
  TextEditingController _matriculaController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _matriculaController.dispose();
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
          title: Text('Error'),
          content: Text('Failed to retrieve current location.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _submitData() async {
    try {
      final matricula = _matriculaController.text;
      final description = _descriptionController.text;
      final latitude = _currentPosition!.latitude;
      final longitude = _currentPosition!.longitude;

      final response = await http.post(
        Uri.parse('YOUR_ENDPOINT_URL_HERE'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'matricula': matricula,
          'description': description,
          'latitude': latitude,
          'longitude': longitude,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: _matriculaController,
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
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.file(widget.imageFile),
              ),
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
                onPressed: _submitData,
                child: const Text('Submit'),
              ),
              SizedBox(width: 20),
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
    );
  }
}
