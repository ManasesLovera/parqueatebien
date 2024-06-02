import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web/SplashScreen.dart';
import 'dart:convert';
import 'PlacaScreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Parqueate Bien',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 6, 67, 117),
        colorScheme: ColorScheme.light(primary: Color.fromARGB(255, 229, 235, 240)),
        scaffoldBackgroundColor: Colors.white,
      ),
      home:SplashScreen(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final TextEditingController _licensePlateController = TextEditingController();
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
        var citizen = parseResponse(response.body);
        print(response);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlacaScreen(
              licensePlate: citizen.licensePlate,
              vehicleType: citizen.vehicleType,
              address: citizen.address,
              vehicleColor: citizen.vehicleColor,
              status: citizen.status,
              lat: citizen.lat,
              lon: citizen.lon,
              photos: citizen.photos,
            ),
          ),
        );
      } else if (response.statusCode == 404) {
        setState(() {
          _errorMessage = 'Incauto not found';
        });
      } else {
        setState(() {
          _errorMessage = 'Invalid plate: ${response.statusCode}';
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

  Citizen parseResponse(String responseBody) {
    final parsed = json.decode(responseBody);
    return Citizen.fromJson(parsed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150.0,
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/image/LOGO_PARQUEATE.png',
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            const Text('Introdusca el Numero de Placa De su Vehiculo'),
            Container(height: 20,)
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Spacer(),
            TextField(
              controller: _licensePlateController,
              decoration: const InputDecoration(
                labelText: 'Ingresar Digitos De Placa',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {}); // Actualizar el estado para habilitar/deshabilitar el botón
              },
            ),
            const SizedBox(height: 38.0),
            Spacer(),
            _isLoading
                ? CircularProgressIndicator()
                : _errorMessage.isNotEmpty
                    ? Text(_errorMessage)
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _licensePlateController.text.isEmpty ? null : _getCitizen,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _licensePlateController.text.isEmpty ? Colors.grey : Color.fromARGB(255, 0, 18, 153),
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: _isLoading ? CircularProgressIndicator() : const Text('consultar'),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}



Citizen citizenFromJson(String str) => Citizen.fromJson(json.decode(str));

String citizenToJson(Citizen data) => json.encode(data.toJson());

class Citizen {
    String licensePlate;
    String vehicleType;
    String vehicleColor;
    String address;
    String status;
    String lat;
    String lon;
    List<Photo> photos;

    Citizen({
        required this.licensePlate,
        required this.vehicleType,
        required this.vehicleColor,
        required this.address,
        required this.status,
        required this.lat,
        required this.lon,
        required this.photos,
    });

    factory Citizen.fromJson(Map<String, dynamic> json) => Citizen(
        licensePlate: json["LicensePlate"],
        vehicleType: json["VehicleType"],
        vehicleColor: json["VehicleColor"],
        address: json["Address"],
        status: json["Status"],
        lat: json["Lat"],
        lon: json["Lon"],
        photos: List<Photo>.from(json["Photos"].map((x) => Photo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "LicensePlate": licensePlate,
        "VehicleType": vehicleType,
        "VehicleColor": vehicleColor,
        "Address": address,
        "Status": status,
        "Lat": lat,
        "Lon": lon,
        "Photos": List<dynamic>.from(photos.map((x) => x.toJson())),
    };
}

class Photo {
    String licensePlate;
    String fileType;
    String file;

    Photo({
        required this.licensePlate,
        required this.fileType,
        required this.file,
    });

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        licensePlate: json["LicensePlate"],
        fileType: json["FileType"],
        file: json["File"],
    );

    Map<String, dynamic> toJson() => {
        "LicensePlate": licensePlate,
        "FileType": fileType,
        "File": file,
    };
}