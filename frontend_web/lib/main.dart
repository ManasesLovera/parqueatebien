import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final TextEditingController _licensePlateController = TextEditingController();
  List<Incauto> _incautos = [];

  @override
  void dispose() {
    _licensePlateController.dispose();
    super.dispose();
  }

  Future<void> _buscarIncautos() async {
    String matricula = _licensePlateController.text;
    var response = await http.get(Uri.parse('http://localhost:8089/ciudadanos/$matricula'));
     print('su inf:${response.body}');
    if (response.statusCode == 200) {
      setState(() {
        _incautos = parseResponse(response.body);
      });
    } else {
     
     print('Error when making request: ${response.statusCode}');
    }
  }

  List<Incauto> parseResponse(String responseBody) {
  print("Respuesta JSON cruda: $responseBody");
  
  final parsed = json.decode(responseBody);
  if (parsed['citizen'] != null) {
    Incauto incauto = Incauto.fromJson(parsed['citizen']);
    print("Objeto Incauto después del parseo: $incauto");
    return [incauto];
  } else {
    print("No se encontró el objeto 'citizen' en la respuesta.");
    return [];
  }
}
  @override
  Widget build(BuildContext context){ 
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        colorScheme: const ColorScheme.light(primary: Color.fromARGB(255, 229, 235, 240)),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Search Incautos'),
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
                  labelText: 'Enter the Registration',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _buscarIncautos,
                child: const Text('Search'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
               const SizedBox(height: 16.0),
               Expanded(
                child: _incautos.isNotEmpty
                    ? ListView.builder(
                        itemCount: _incautos.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 8.0,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),                         
                            child: ListTile(
                              title: Column(
                                children: [
                                  Text(
                                   _incautos[index].lat,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),Text(
                                   _incautos[index].lon,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),Text(
                                   _incautos[index].photo,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  
                                ],
                              ),
                              subtitle: Text(_incautos[index].licensePlate),
                              // Agrega más elementos ListTile según los datos que quieras mostrar
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text('No suspects were found'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Incauto {
  final String photo;
  final String licensePlate;
  final String lat;
  final String lon;

  Incauto({
    required this.photo,
    required this.licensePlate,
    required this.lat,
    required this.lon,
  });

  factory Incauto.fromJson(Map<String, dynamic> json) {
    return Incauto(
      photo: json['photo'] as String,
      licensePlate: json['licensePlate'] as String,
      lat: json['location']['lat'] as String,
      lon: json['location']['lon'] as String,
    );
  }}