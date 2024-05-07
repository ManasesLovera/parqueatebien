import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
 import 'package:flutter/widgets.dart';
import 'dart:io';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final TextEditingController _licensePlateController = TextEditingController();
  List<Citizen> _citizens = [];
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _licensePlateController.dispose();
    super.dispose();
  }

  Future<void> _getCitizen() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    String licensePlate = _licensePlateController.text;
    try {
var response = await http.get(Uri.parse('http://localhost:8089/ciudadanos/$licensePlate'));
      if (response.statusCode == 200) {
        setState(() {
          _citizens = parseResponse(response.body);
          // print(response.body);
        });
      } else if (response.statusCode == 404) {
        setState(() {
          _errorMessage = 'Incauto not found';
        });
      } else {
        setState(() {
          _errorMessage = 'invalid plate: ${response.statusCode}';
          showErrorDialog(_errorMessage);
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
  List<Citizen> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody);
    if (parsed['LicensePlate'] != null) {
      return [Citizen.fromJson(parsed)];
    } else {
      return [];
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        colorScheme: const ColorScheme.light(primary: Color.fromARGB(255, 229, 235, 240)),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Search Citizens'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _licensePlateController,
                decoration: const InputDecoration(
                  labelText: 'Enter the License Plate',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _isLoading ? null : _getCitizen,
                child: _isLoading ? CircularProgressIndicator() : const Text('Search'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
              const SizedBox(height: 16.0),
              _isLoading
                  ? CircularProgressIndicator()
                  : _errorMessage.isNotEmpty
                      ? Text(_errorMessage)
                      : Expanded(
                          child: _citizens.isNotEmpty
                              ? ListView.builder(
                                  itemCount: _citizens.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Card(
                                      elevation: 8.0,
                                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: ListTile(
                                        title: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
SizedBox(
  width: 150, 
  height: 150,
  child: ClipRRect(
    borderRadius: BorderRadius.circular(8.0),
    child: Image.memory(
      base64Decode(_citizens[index].photoBase64),
      fit: BoxFit.cover, 
    ),
  ),
),                                           
                                            Text(
                                            _citizens[index].licensePlate,
                                             style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                            _citizens[index].lat,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),Text(
                                            _citizens[index].lon,
                                             style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),Text(
                                            _citizens[index].description,
                                             style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),

                                          ],
                                        ),
                                         subtitle: Text(_citizens[index].licensePlate),
                                      ),
                                    );
                                  },
                                )
                              : const Center(
                                  child: Text('No citizens found'),
                                ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}

class Citizen {
  final String licensePlate;
  final String description;
  final String lat;
  final String lon;
  final String photoBase64;
  final String fileType;

  Citizen({
    required this.licensePlate,
    required this.description,
    required this.lat,
    required this.lon,
    required this.photoBase64,
    required this.fileType
  });

  Future<void> savePhoto(String filePath) async {
    Uint8List bytes = base64Decode(photoBase64);
    await File(filePath).writeAsBytes(bytes);
  }

  factory Citizen.fromJson(Map<String, dynamic> json) {
    return Citizen(
      licensePlate: json['LicensePlate'] as String,
      description: json['Description'] as String,
      lat: json['Lat'] as String,
      lon: json['Lon'] as String,
      photoBase64: json['File'] as String,
      fileType: json['FileType'] as String
    );
  }
}
