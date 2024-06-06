import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'PlacaScreen.dart';
import 'SplashScreen.dart';

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
        colorScheme:
            ColorScheme.light(primary: Color.fromARGB(255, 203, 225, 243)),
        scaffoldBackgroundColor: Color.fromARGB(255, 203, 225, 243),
      ),
      home: SplashScreen(),
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
      var response = await http
          .get(Uri.parse('http://localhost:8089/ciudadanos/$licensePlate'));
      if (response.statusCode == 200) {
        var citizen = parseResponse(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlacaScreen(
              licensePlate: citizen.licensePlate,
              vehicleType: citizen.vehicleType,
              address: citizen.address,
              vehicleColor: citizen.vehicleColor,
              status: citizen.status,
              currentAddress: citizen.currentAddress,
              reportedDate: citizen.reportedDate,
              towedByCraneDate: citizen.towedByCraneDate,
              arrivalAtParkinglot: citizen.arrivalAtParkinglot,
              releaseDate: citizen.releaseDate ,
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
        toolbarHeight: 200.0,
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/LOGO_PARQUEATE.png',
              height: 100, // Reduce the logo height slightly
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 50),
            Center(
              child: Text(
                'INTRODUZCA EL NÚMERO DE PLACA DE SU VEHÍCULO',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                 color: Color(0xFF010F56)
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Spacer(),
            SizedBox(
              width: 800, // Ajusta el ancho del campo de entrada aquí
              child: TextField(
                controller: _licensePlateController,
                decoration: const InputDecoration(
                  labelText: 'Ingresar Dígitos De Placa',
                  border: OutlineInputBorder(),
                ),
                maxLength: 7, // Limitar la entrada a 7 caracteres
                onChanged: (value) {
                  setState(
                      () {}); // Actualizar el estado para habilitar/deshabilitar el botón
                },
              ),
            ),
            const SizedBox(height: 500),
            _isLoading
                ? CircularProgressIndicator()
                : _errorMessage.isNotEmpty
                    ? Column(
                        children: [
                          Text(_errorMessage),
                          const SizedBox(height: 16.0),
                          _buildConsultButton(),
                        ],
                      )
                    : _buildConsultButton(),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildConsultButton() {
    return Align(
      alignment: Alignment.center, // Centrar el botón horizontalmente
      child: SizedBox(
        width: 300, // Ajusta el ancho del botón aquí
        child: ElevatedButton(
          onPressed:
              _licensePlateController.text.length == 7 ? _getCitizen : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _licensePlateController.text.length == 7
                ? Color.fromARGB(255, 0, 18, 153)
                : Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: _isLoading
              ? CircularProgressIndicator()
              : const Text(
                  'consultar',
                  style: TextStyle(
                      color:
                          Colors.white), // Cambiar el color del texto a blanco
                ),
        ),
      ),
    );
  }
}

// To parse this JSON data, do

//     final citizen = citizenFromJson(jsonString);


Citizen citizenFromJson(String str) => Citizen.fromJson(json.decode(str));

String citizenToJson(Citizen data) => json.encode(data.toJson());

class Citizen {
    String licensePlate;
    String vehicleType;
    String vehicleColor;
    String address;
    String status;
    String currentAddress;
    String reportedDate;
    String towedByCraneDate;
    String arrivalAtParkinglot;
    String releaseDate;
    String lat;
    String lon;
    List<Photo> photos;

    Citizen({
        required this.licensePlate,
        required this.vehicleType,
        required this.vehicleColor,
        required this.address,
        required this.status,
        required this.currentAddress,
        required this.reportedDate,
        required this.towedByCraneDate,
        required this.arrivalAtParkinglot,
        required this.releaseDate,
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
        currentAddress: json["CurrentAddress"],
        reportedDate: json["ReportedDate"],
        towedByCraneDate: json["TowedByCraneDate"],
        arrivalAtParkinglot: json["ArrivalAtParkinglot"],
        releaseDate: json["ReleaseDate"],
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
        "CurrentAddress": currentAddress,
        "ReportedDate": reportedDate,
        "TowedByCraneDate": towedByCraneDate,
        "ArrivalAtParkinglot": arrivalAtParkinglot,
        "ReleaseDate": releaseDate,
        "Lat": lat,
        "Lon": lon,
        "Photos": List<dynamic>.from(photos.map((x) => x.toJson())),
    };
}

class Photo {
    String fileType;
    String file;

    Photo({
        required this.fileType,
        required this.file,
    });

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        fileType: json["FileType"],
        file: json["File"],
    );

    Map<String, dynamic> toJson() => {
        "FileType": fileType,
        "File": file,
    };
}