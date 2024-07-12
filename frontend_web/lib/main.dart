import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'PlacaScreen.dart';
import 'SplashScreen.dart';
import 'dart:io';

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
        primaryColor: Color.fromARGB(255, 1, 15, 117),
        colorScheme: ColorScheme.light(primary: Color.fromARGB(255, 1, 15, 86)),
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
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
    var response = await http.get(
      Uri.parse('http://localhost:8089/api/reporte/$licensePlate'),
    );

    if (response.statusCode == 200) {
      var citizen = parseResponse(response.body);

      if (citizen.status.toLowerCase() == 'liberado') {
        setState(() {
          _errorMessage = 'No hay reportes activos para esta placa';
        });
      } else {
        double lat = 0.0;
        double lon = 0.0;

        try {
          lat = double.parse(citizen.lat);
          lon = double.parse(citizen.lon);
        } catch (e) {
          print('Error al convertir latitud o longitud: $e');
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlacaScreen(
              registrationNumber: citizen.registrationNumber,
              licensePlate: citizen.licensePlate,
              registrationDocument: citizen.registrationDocument,
              vehicleType: citizen.vehicleType,
              vehicleColor: citizen.vehicleColor,
              model: citizen.model,
              year: citizen.year,
              reference: citizen.reference,
              status: citizen.status,
              reportedDate: citizen.reportedDate,
              towedByCraneDate: citizen.towedByCraneDate,
              arrivalAtParkinglot: citizen.arrivalAtParkinglot,
              releaseDate: citizen.releaseDate,
              lat: lat,
              lon: lon,
              photos: citizen.photos.map((photo) => photo.file).toList(),
            ),
          ),
        );
      }
    } else if (response.statusCode == 404) {
      setState(() {
        _errorMessage = 'Incauto no encontrado';
      });
    } else {
      setState(() {
        _errorMessage = 'Error al consultar la placa: ${response.statusCode}';
      });
    }
  } catch (e) {
    if (e is SocketException) {
      setState(() {
        _errorMessage = 'No se pudo conectar al servidor. Verifique su conexión a Internet.';
      });
    } else if (e is HttpException) {
      setState(() {
        _errorMessage = 'Error de servidor: ${e.message}';
      });
    } else if (e is FormatException) {
      setState(() {
        _errorMessage = 'Respuesta de formato incorrecto.';
      });
    } else {
      setState(() {
        _errorMessage = 'Error desconocido: $e';
      });
    }
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
        toolbarHeight: 10.0,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(1),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/image/LOGO_PARQUEATE.png',
                      height: 125,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: Text(
                        'INTRODUZCA EL NÚMERO DE PLACA DE SU VEHÍCULO',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF010F56),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Text(
                          'Placa:',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 1, 15, 117),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: 700,
                          child: TextField(
                            controller: _licensePlateController,
                            decoration: InputDecoration(
                              hintText: 'Ingresar Dígitos De Placa',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color.fromARGB(255, 240, 240, 240),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            ),
                            maxLength: 7,
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    if (_isLoading) ...[
                      CircularProgressIndicator(),
                      const SizedBox(height: 2),
                    ],
                    if (_errorMessage.isNotEmpty) ...[
                      Text(_errorMessage),
                      const SizedBox(height: 1),
                    ],
                    _buildConsultButton(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildConsultButton() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 400.0), // Ajusta el margen inferior aquí
        child: SizedBox(
          width: 300,
          child: ElevatedButton(
            onPressed: _licensePlateController.text.length == 7 ? _getCitizen : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _licensePlateController.text.length == 7
                  ? Color.fromARGB(255, 1, 15, 86)
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
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

Citizen citizenFromJson(String str) => Citizen.fromJson(json.decode(str));

String citizenToJson(Citizen data) => json.encode(data.toJson());

class Citizen {
    String registrationNumber;
    String licensePlate;
    String registrationDocument;
    String vehicleType;
    String vehicleColor;
    String model;
    String year;
    String reference;
    String status;
    String reportedBy;
    String reportedDate;
    dynamic towedByCraneDate;
    dynamic arrivalAtParkinglot;
    dynamic releaseDate;
    dynamic releasedBy;
    String lat;
    String lon;
    List<Photo> photos;

    Citizen({
        required this.registrationNumber,
        required this.licensePlate,
        required this.registrationDocument,
        required this.vehicleType,
        required this.vehicleColor,
        required this.model,
        required this.year,
        required this.reference,
        required this.status,
        required this.reportedBy,
        required this.reportedDate,
        required this.towedByCraneDate,
        required this.arrivalAtParkinglot,
        required this.releaseDate,
        required this.releasedBy,
        required this.lat,
        required this.lon,
        required this.photos,
    });

    factory Citizen.fromJson(Map<String, dynamic> json) => Citizen(
        registrationNumber: json["registrationNumber"],
        licensePlate: json["licensePlate"],
        registrationDocument: json["registrationDocument"],
        vehicleType: json["vehicleType"],
        vehicleColor: json["vehicleColor"],
        model: json["model"],
        year: json["year"],
        reference: json["reference"],
        status: json["status"],
        reportedBy: json["reportedBy"],
        reportedDate: json["reportedDate"],
        towedByCraneDate: json["towedByCraneDate"],
        arrivalAtParkinglot: json["arrivalAtParkinglot"],
        releaseDate: json["releaseDate"],
        releasedBy: json["releasedBy"],
        lat: json["lat"],
        lon: json["lon"],
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "registrationNumber": registrationNumber,
        "licensePlate": licensePlate,
        "registrationDocument": registrationDocument,
        "vehicleType": vehicleType,
        "vehicleColor": vehicleColor,
        "model": model,
        "year": year,
        "reference": reference,
        "status": status,
        "reportedBy": reportedBy,
        "reportedDate": reportedDate,
        "towedByCraneDate": towedByCraneDate,
        "arrivalAtParkinglot": arrivalAtParkinglot,
        "releaseDate": releaseDate,
        "releasedBy": releasedBy,
        "lat": lat,
        "lon": lon,
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
    };
}

class Photo {
    String file;
    String fileType;

    Photo({
        required this.file,
        required this.fileType,
    });

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        file: json["file"],
        fileType: json["fileType"],
    );

    Map<String, dynamic> toJson() => {
        "file": file,
        "fileType": fileType,
    };
}
