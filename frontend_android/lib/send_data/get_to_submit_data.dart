import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// Use logger FrameWork
import 'package:logger/logger.dart';

// Use logger FrameWork
final Logger _logger = Logger();
// Using callback to avoid directly passing the BuildContext
typedef ShowDialogCallback = void Function();

Future<void> submitData({
  required BuildContext context,
  required TextEditingController licensePlateController,
  required TextEditingController descriptionController,
  required Position currentPosition,
  required File imageFile,
  required ShowDialogCallback showDialog,
}) async {
  try {
    final licensePlate = licensePlateController.text;
    final description = descriptionController.text;
    final latitude = currentPosition.latitude;
    final longitude = currentPosition.longitude;
    String type = 'image/jpeg';
    if (imageFile.path.endsWith('.png')) {
      type = 'image/png';
    } else if (imageFile.path.endsWith('.gif')) {
      type = 'image/gif';
    }

    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    final response = await http.post(
      Uri.parse('http://192.168.0.236:8089/ciudadanos'),
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
      //  print('Datos enviados Correctamente');
      _logger.e('Exito !: Datos enviados Correctamente');
      /*
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Éxito Enviados !'),
          content: const Text('Exito !: Datos enviados Correctamente'),
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
    
    */
    } else {
      String message;
      switch (response.statusCode) {
        case 409:
          message = 'Error Matricula Ya Existe !.';
          break;
        case 500:
          message = 'Error Interno, Por favor, inténtelo más tarde.';
          break;
        case 400:
          message = 'Error. Verifique los datos e Intente Nuevamente.';
          break;
        default:
          message = 'Error desconocido. Por favor, inténtelo más tarde.';
      }
      _logger.e('Error: $message');
      showDialog();
      /*
      // using mounted property of the State.
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error '),
          content: Text(message),
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
    
    */
    }
  } catch (e) {
    // Handle any exceptions
    _logger.e('Error: Al enviar los datos $e');
    showDialog();
  }
}
