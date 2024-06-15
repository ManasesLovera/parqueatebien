import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/screens/_03_Consulta/_01_detalles_vehiculo.dart';
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
  final _formKey = GlobalKey<FormState>();
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
        _handleError('Vehicle not found or server error.');
      }
    } catch (e) {
      _handleError('Failed to connect to the server: $e');
    }
  }

  void _handleError(String message) {
    _logger.e('Error: $message');
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
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
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                Center(
                  child: Image.asset(
                    'assets/whiteback/main_w.png',
                    height: 50.h,
                  ),
                ),
                SizedBox(height: 65.h),
                Center(
                  child: Text(
                    'Introduzca el número de placa de su vehículo',
                    style: TextStyle(
                      fontSize: 16.h,
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
                      color: Colors.blueAccent,
                      fontSize: 12.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                SizedBox(
                  height: 40.h,
                  child: TextFormField(
                    controller: _plateController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.w, horizontal: 20.w),
                      hintText: 'Ingresar Dígitos de la placa',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10.h),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^[A-Z][0-9]{0,6}$')),
                      LengthLimitingTextInputFormatter(7),
                    ],
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Ingrese una placa válida';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 270.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isButtonEnabled ? _searchVehicle : null,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.w),
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
      ),
    );
  }
}
