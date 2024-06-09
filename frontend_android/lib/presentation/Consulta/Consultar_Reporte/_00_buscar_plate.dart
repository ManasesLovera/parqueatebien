import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/presentation/Consulta/Consultar_Reporte/_01_detalles_vehiculo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

class EnterPlateNumberScreen extends StatefulWidget {
  const EnterPlateNumberScreen({super.key});

  @override
  EnterPlateNumberScreenState createState() => EnterPlateNumberScreenState();
}

class EnterPlateNumberScreenState extends State<EnterPlateNumberScreen> {
  final TextEditingController _plateController = TextEditingController();
  bool _isButtonEnabled = false;
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    _plateController.addListener(_checkInput);
  }

  void _checkInput() {
    setState(() {
      _isButtonEnabled = _plateController.text.length == 7;
    });
  }

  Future<void> _searchVehicle() async {
    const String baseUrl =
        'https://parqueatebiendemo.azurewebsites.net/ciudadanos/';
    final String endpoint = _plateController.text;
    final Uri url = Uri.parse('$baseUrl$endpoint');

    try {
      _logger.i('Attempting to fetch vehicle details from $url...');
    final response = await http.get(url).timeout(const Duration(seconds: 45));

      _logger.i('HTTP response status: ${response.statusCode}');
      if (!mounted) return;

      if (response.statusCode == 200) {
        final vehicleData = jsonDecode(response.body);
        _logger.i('Vehicle details fetched successfully: $vehicleData');
        if (mounted) {
          _logger.i('Navigating to VehicleDetailsScreen...');
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  VehicleDetailsScreen(vehicleData: vehicleData),
            ),
          );
        }
      } else {
        _logger.e(
            'Failed to fetch vehicle details. Status code: ${response.statusCode}');
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: const Text('Vehicle not found or server error.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      }
    } catch (e) {
      _logger.e('Failed to connect to the server: $e');
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to connect to the server: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _plateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),
              Center(
                child: Image.asset(
                  'assets/whiteback/main_w.png',
                  height: 100.h,
                ),
              ),
              SizedBox(height: 30.h),
              Center(
                child: Text(
                  'Introduzca el número de placa de su vehículo',
                  style: TextStyle(
                    fontSize: 18.h,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Placa',
                  style: TextStyle(
                    fontSize: 16.h,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              TextField(
                controller: _plateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  hintText: 'Ingresar dígitos de la placa',
                ),
                maxLength: 7,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^[A-Z][0-9]{0,6}$')),
                  LengthLimitingTextInputFormatter(7),
                ],
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 200.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled ? _searchVehicle : null,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    backgroundColor:
                        _isButtonEnabled ? Colors.blue : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'Consultar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
