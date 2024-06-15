import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Services/location/_location_.dart';
import 'package:frontend_android/config/Report_Buttons/geo_labels.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  NewReportScreenState createState() => NewReportScreenState();
}

class NewReportScreenState extends State<ReportScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _plateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _selectedVehicleType;
  String? _selectedColor;
  bool _isFormValid = false;
  bool _plateFieldTouched = false;
  bool _addressFieldTouched = false;
  bool _vehicleTypeTouched = false;
  bool _colorTouched = false;
  String? _latitude;
  String? _longitude;

  // Focus
  final FocusNode _plateFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();
  final FocusNode _vehicleTypeFocusNode = FocusNode();
  final FocusNode _colorFocusNode = FocusNode();

  // Logger
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    _plateController.addListener(_validateForm);
    _addressController.addListener(_validateForm);
    _getLocation();

    _plateFocusNode.addListener(() {
      if (!_plateFocusNode.hasFocus) {
        setState(() {
          _plateFieldTouched = true;
        });
      }
    });

    _vehicleTypeFocusNode.addListener(() {
      if (!_vehicleTypeFocusNode.hasFocus) {
        setState(() {
          _vehicleTypeTouched = true;
        });
      }
    });
    _colorFocusNode.addListener(() {
      if (!_colorFocusNode.hasFocus) {
        setState(() {
          _colorTouched = true;
        });
      }
    });
    _addressFocusNode.addListener(() {
      if (!_addressFocusNode.hasFocus) {
        setState(() {
          _addressFieldTouched = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _plateController.dispose();
    _plateFocusNode.dispose();
    _addressFocusNode.dispose();
    _addressController.dispose();
    _vehicleTypeFocusNode.dispose();
    _colorFocusNode.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = (_formKey.currentState?.validate() ?? false) &&
          _selectedVehicleType != null &&
          _selectedColor != null &&
          _plateController.text.isNotEmpty &&
          _addressController.text.isNotEmpty;
    });
  }

  String? _getValidationMessage() {
    if (_plateController.text.isEmpty) {
      return 'Por favor ingrese un número de placa';
    }
    if (!RegExp(r'^[A-Z][0-9]{6}$').hasMatch(_plateController.text)) {
      return 'La placa debe empezar con una letra mayúscula seguida de 6 números';
    }
    if (_selectedVehicleType == null) {
      return 'Seleccione un tipo de vehículo';
    }
    if (_selectedColor == null) {
      return 'Seleccione un color';
    }
    if (_addressController.text.isEmpty) {
      return 'Por favor ingrese una dirección';
    }
    return null;
  }

  void _validateOnSubmit() {
    setState(() {
      _plateFieldTouched = true;
      _vehicleTypeTouched = true;
      _colorTouched = true;
      _addressFieldTouched = true;
    });

    final validationMessage = _getValidationMessage();
    if (validationMessage != null) {
      _showSnackBar(validationMessage);
      return;
    }

    if (_isFormValid) {
      _navigateToPhotoScreen();
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    Navigator.pushNamed(
      context,
      '/foto',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    'Nuevo reporte',
                    style: TextStyle(
                      fontSize: 22.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Datos del vehículo',
                    style: TextStyle(
                      fontSize: 14.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Numero de placa',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 10.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.h, vertical: 0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.h,
                          child: TextFormField(
                            style: const TextStyle(color: Colors.black),
                            controller: _plateController,
                            focusNode: _plateFocusNode,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 4.w, horizontal: 8.h),
                              hintText: 'Ingrese numero',
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 10.h),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r)),
                                borderSide:
                                    const BorderSide(color: Colors.black12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r)),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[A-Z0-9]')),
                              LengthLimitingTextInputFormatter(7),
                            ],
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              setState(() {
                                // Trigger a rebuild to show or hide the error message
                              });
                            },
                          ),
                        ),
                        if (_plateFieldTouched &&
                            !_plateController.text.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.w, horizontal: 14.h),
                            child: Text(
                              'Por favor ingrese un número de placa',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 10.h),
                            ),
                          ),
                        if (_plateFieldTouched &&
                            _plateController.text.isNotEmpty &&
                            !RegExp(r'^[A-Z][0-9]{6}$')
                                .hasMatch(_plateController.text))
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.w, horizontal: 14.h),
                            child: Text(
                              'La placa debe empezar con una letra mayúscula seguida de 6 números',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 10.h),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tipo de vehiculo',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 10.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: SizedBox(
                      height: 30.h,
                      child: DropdownButtonFormField<String>(
                        focusNode: _vehicleTypeFocusNode,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 4.w, horizontal: 8.h),
                          isDense: true,
                          hintText: 'Seleccionar',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.h),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r)),
                            borderSide: const BorderSide(color: Colors.black12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r)),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
                        items: <String>['Automovil', 'Motor', 'Bicicleta']
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
                        validator: (value) {
                          if (!_vehicleTypeTouched) return null;
                          return value == null
                              ? 'Seleccione un tipo de vehículo'
                              : null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Color',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 10.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: SizedBox(
                      height: 30.h,
                      child: DropdownButtonFormField<String>(
                        focusNode: _colorFocusNode,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 4.w, horizontal: 8.h),
                          isDense: true,
                          hintText: 'Seleccionar',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.h),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r)),
                            borderSide: const BorderSide(color: Colors.black12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r)),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
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
                        validator: (value) {
                          if (!_colorTouched) return null;
                          return value == null ? 'Seleccione un color' : null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Direccion',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 10.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          //   height: 30.h,
                          child: TextFormField(
                            controller: _addressController,
                            focusNode: _addressFocusNode,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 4.w, horizontal: 8.h),
                              hintText: 'Ingresar',
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 10.h),
                              filled: true,
                              fillColor: Colors.white,
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r)),
                                borderSide:
                                    const BorderSide(color: Colors.black12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r)),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                // Trigger a rebuild to show or hide the error message
                              });
                            },
                          ),
                        ),
                        if (_addressFieldTouched &&
                            _addressController.text.isEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.w, horizontal: 14.h),
                            child: Text(
                              'Por favor ingrese una dirección',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 10.h),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Dirección donde el vehículo está mal parqueado',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  if (_latitude != null && _longitude != null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Datos Geográficos',
                            style: TextStyle(
                              fontSize: 11.h,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          DetailItem(
                            title: 'Latitud',
                            content: _latitude!,
                          ),
                          DetailItem(
                            title: 'Longitud',
                            content: _longitude!,
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 50.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.h, vertical: 14.w),
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
                          onPressed: _isFormValid ? _validateOnSubmit : null,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
