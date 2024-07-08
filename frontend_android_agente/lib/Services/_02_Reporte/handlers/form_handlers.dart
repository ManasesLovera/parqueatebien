import 'package:flutter/material.dart';
import 'package:frontend_android/Services/_02_Reporte/api/location_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class FormHandlers {
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

  FormHandlers({
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
    // addressController.text.isNotEmpty;
  }

  String? getValidationMessage() {
    if (plateController.text.isEmpty) {
      return 'Por favor ingrese un número de placa';
    }
    if (!RegExp(r'^[A-Z][0-9]{6}$').hasMatch(plateController.text)) {
      return 'La placa debe empezar con una letra mayúscula seguida de 6 números';
    }
    if (selectedVehicleType == null) {
      return 'Seleccione un tipo de vehículo';
    }
    if (selectedColor == null) {
      return 'Seleccione un color';
    }
    // if (addressController.text.isEmpty) {
    //   return 'Por favor ingrese una dirección';
    // }
    return null;
  }

  void validateOnSubmit(BuildContext context) {
    plateFieldTouched = true;
    vehicleTypeTouched = true;
    colorTouched = true;
    addressFieldTouched = true;

    final validationMessage = getValidationMessage();
    if (validationMessage != null) {
      showSnackBar(validationMessage);
      return;
    }

    if (isFormValid) {
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

  Future<void> getLocation() async {
    try {
      final locationService = LocationService();
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        showDialog('Por favor, Activar la ubicacions.');
        return;
      }

      Position? position = await locationService.getCurrentLocation();
      if (position != null) {
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
      } else {
        logger.e('Error Fatal! Localization');
        showDialog('Por favor, Aceptar los Permisos de Ubicacion');
      }
    } catch (e) {
      logger.e('Error Fatal! Current Locations');
      showDialog('Error Fatal Error: Could not retrieve current location.');
    }
  }
}
