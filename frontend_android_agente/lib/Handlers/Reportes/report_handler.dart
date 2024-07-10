import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend_android/APis/_03_location.dart';
import 'package:frontend_android/Handlers/Consulta/dialog_success_error_consulta.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class FormHandlersReport {
  final GlobalKey<FormState> formKey;
  final TextEditingController plateController;
  final TextEditingController addressController;
  final Function(String) showSnackBar;
  final Function(String) showDialog;

  String? selectedVehicleType;
  String? selectedColor;
  String? latitude;
  String? longitude;
  bool plateFieldTouched = false;
  bool addressFieldTouched = false;
  bool vehicleTypeTouched = false;
  bool colorTouched = false;
  bool isFormValid = false;

  final Logger logger = Logger();
  final LocationService _locationService = LocationService();
  StreamSubscription<Position>? _positionStreamSubscription;
  final StreamController<Position> _positionStreamController =
      StreamController<Position>.broadcast();

  Stream<Position> get positionStream => _positionStreamController.stream;

  FormHandlersReport({
    required this.formKey,
    required this.plateController,
    required this.addressController,
    required this.showSnackBar,
    required this.showDialog,
  });

  void validateForm() {
    isFormValid = (formKey.currentState?.validate() ?? false) &&
        selectedVehicleType != null &&
        selectedColor != null &&
        plateController.text.isNotEmpty;
  }

  void validateField(BuildContext context, String field) {
    switch (field) {
      case 'plate':
        if (plateController.text.isEmpty) {
          showUniversalSuccessErrorDialogConsulta(
              context, 'Por favor ingrese un número de placa', false);
        } else if (!RegExp(r'^[A-Z][0-9]{6}$').hasMatch(plateController.text)) {
          showUniversalSuccessErrorDialogConsulta(
              context,
              'La placa debe empezar con una letra mayúscula seguida de 6 números',
              false);
        }
        break;
      case 'vehicleType':
        if (selectedVehicleType == null && vehicleTypeTouched) {
          showUniversalSuccessErrorDialogConsulta(
              context, 'Seleccione un tipo de vehículo', false);
        }
        break;
      case 'color':
        if (selectedColor == null && colorTouched) {
          showUniversalSuccessErrorDialogConsulta(
              context, 'Seleccione un color', false);
        }
        break;
      default:
        break;
    }
  }

  Future<void> getLocation(BuildContext context) async {
    bool serviceEnabled = await _locationService.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showUniversalSuccessErrorDialogConsulta(
          context, 'Por favor, active la ubicación.', false);
      Geolocator.getServiceStatusStream().listen((ServiceStatus status) async {
        if (status == ServiceStatus.enabled) {
          bool permissionGranted =
              await _locationService.requestLocationPermission();
          if (permissionGranted) {
            _startListeningToLocation();
          } else {
            showUniversalSuccessErrorDialogConsulta(
                context, 'Por favor, acepte los permisos de ubicación.', false);
          }
        }
      });
      return;
    }

    bool permissionGranted = await _locationService.requestLocationPermission();
    if (!permissionGranted) {
      showUniversalSuccessErrorDialogConsulta(
          context, 'Por favor, acepte los permisos de ubicación.', false);
      return;
    }

    _startListeningToLocation();
  }

  void _startListeningToLocation() {
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    ).listen((Position position) {
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
      _positionStreamController.add(position);
    });
  }

  void dispose() {
    _positionStreamSubscription?.cancel();
    _positionStreamController.close();
  }

  void validateOnSubmit(BuildContext context) {
    plateFieldTouched = true;
    vehicleTypeTouched = true;
    colorTouched = true;
    addressFieldTouched = true;

    if (plateController.text.isEmpty) {
      showUniversalSuccessErrorDialogConsulta(
          context, 'Por favor ingrese un número de placa', false);
      return;
    }

    if (!RegExp(r'^[A-Z][0-9]{6}$').hasMatch(plateController.text)) {
      showUniversalSuccessErrorDialogConsulta(
          context,
          'La placa debe empezar con una letra mayúscula seguida de 6 números',
          false);
      return;
    }

    if (selectedVehicleType == null) {
      showUniversalSuccessErrorDialogConsulta(
          context, 'Seleccione un tipo de vehículo', false);
      return;
    }

    if (selectedColor == null) {
      showUniversalSuccessErrorDialogConsulta(
          context, 'Seleccione un color', false);
      return;
    }

    validateForm(); // Validate the entire form

    if (!isFormValid) {
      return;
    }

    Navigator.pushNamed(
      context,
      '/foto',
      arguments: {
        'plateNumber': plateController.text,
        'vehicleType': selectedVehicleType,
        'color': selectedColor,
        'address': addressController.text,
        'latitude': latitude,
        'longitude': longitude,
      },
    );
  }
}
