import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Services/location_Serv/service/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class NewReportScreen extends StatefulWidget {
  const NewReportScreen({super.key});

  @override
  NewReportScreenState createState() => NewReportScreenState();
}

class NewReportScreenState extends State<NewReportScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _plateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String? _selectedVehicleType;
  String? _selectedColor;
  bool _isFormValid = false;
  String? _latitude;
  String? _longitude;
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    _plateController.addListener(_validateForm);
    _addressController.addListener(_validateForm);
    _getLocation();
  }

  @override
  void dispose() {
    _plateController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _formKey.currentState?.validate() ??
          false && _selectedVehicleType != null && _selectedColor != null;
    });
  }

  Future<void> _getLocation() async {
    try {
      final locationService = LocationService();
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showDialog(
            'Location Service Disabled', 'Please enable location services.');
        return;
      }
      Position? position = await locationService.getCurrentLocation();
      if (position != null) {
        setState(() {
          _latitude = position.latitude.toString();
          _longitude = position.longitude.toString();
        });
      } else {
        _logger.e('Error Fatal! Localization');
        _showDialog('Error', 'Could not retrieve current location.');
      }
    } catch (e) {
      _logger.e('Error Fatal! Current Locations');
      _showDialog('Error', 'Fatal Error: Could not retrieve current location.');
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

void _navigateToPhotoScreen() {
    if (_isFormValid) {
      Navigator.pushNamed(
        context,
        '/newreportfoto',
        arguments: {
          'plateNumber': _plateController.text,
          'vehicleType': _selectedVehicleType,
          'color': _selectedColor,
          'address': _addressController.text,
          'latitude': _latitude,
          'longitude': _longitude,
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.h),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Center(
                    child: Text(
                      'Nuevo reporte',
                      style: TextStyle(
                        fontSize: 24.h,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: Text(
                      'Datos del vehículo',
                      style: TextStyle(
                        fontSize: 16.h,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Número de placa',
                    style: TextStyle(
                      fontSize: 12.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  TextFormField(
                    controller: _plateController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ingrese número de placa: A123456',
                    ),
                    maxLength: 7,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un número de placa';
                      }
                      if (!RegExp(r'^[A-Z][0-9]{6}$').hasMatch(value)) {
                        return 'La placa debe empezar con una letra mayúscula seguida de 6 números';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
                      LengthLimitingTextInputFormatter(7),
                    ],
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'Tipo de vehículo',
                    style: TextStyle(
                      fontSize: 12.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    hint: const Text('Seleccionar'),
                    items: <String>['Carro', 'Moto', 'Bicicleta']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedVehicleType = value;
                        _validateForm();
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Seleccione un tipo de vehículo' : null,
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'Color',
                    style: TextStyle(
                      fontSize: 12.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    hint: const Text('Seleccionar'),
                    items: <String>['Rojo', 'Azul', 'Negro', 'Blanco']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedColor = value;
                        _validateForm();
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Seleccione un color' : null,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Dirección',
                    style: TextStyle(
                      fontSize: 12.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ingresar dirección',
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Ingrese una dirección'
                        : null,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Dirección donde el vehículo está mal parqueado.',
                    style: TextStyle(
                      fontSize: 12.h,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Datos Geográficos',
                    style: TextStyle(
                      fontSize: 16.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  if (_latitude != null && _longitude != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Latitud: $_latitude',
                          style: TextStyle(
                            fontSize: 12.h,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          'Longitud: $_longitude',
                          style: TextStyle(
                            fontSize: 12.h,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.w, vertical: 14.h),
                    child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _isFormValid ? Colors.blue : Colors.grey[400]!,
                              _isFormValid
                                  ? Colors.blueAccent
                                  : Colors.grey[600]!,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: ElevatedButton(
                          onPressed: _isFormValid
                              ? () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    _navigateToPhotoScreen();
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 6.h),
                          ),
                          child: Text(
                            'Siguiente',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.h,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
