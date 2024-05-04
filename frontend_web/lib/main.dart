import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

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
        });
      } else if (response.statusCode == 404) {
        setState(() {
          _errorMessage = 'Citizen not found';
        });
      } else {
        setState(() {
          _errorMessage = 'Error: ${response.statusCode}';
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

  List<Citizen> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody);
    if (parsed['citizen'] != null) {
      return [Citizen.fromJson(parsed['citizen'])];
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
                                            Text('License Plate: ${_citizens[index].licensePlate}'),
                                            Text('Description: ${_citizens[index].description}'),
                                            Text('Location: ${_citizens[index].lat}, ${_citizens[index].lon}'),
                                          ],
                                        ),
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

  Citizen({
    required this.licensePlate,
    required this.description,
    required this.lat,
    required this.lon,
  });

  factory Citizen.fromJson(Map<String, dynamic> json) {
    return Citizen(
      licensePlate: json['licensePlate'] as String,
      description: json['description'] as String,
      lat: json['lat'] as String,
      lon: json['lon'] as String,
    );
  }
}