import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() async {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final TextEditingController _matriculaController = TextEditingController();
  List<Incauto> _incautos = [];

  @override
  void dispose() {
    _matriculaController.dispose();
    super.dispose();
  }

  Future<void> _buscarIncautos() async {
    String matricula = _matriculaController.text;
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
    // Implementa la lógica para parsear la respuesta del servidor y crear objetos Incauto aquí
    return [];
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
          title: const Text('Search Incautos'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _matriculaController,
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
                            elevation: 2.0,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              title: Text(
                                _incautos[index].nombre,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(_incautos[index].apellido),
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
  final String nombre;
  final String apellido;

  Incauto({required this.nombre, required this.apellido});
}