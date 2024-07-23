import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend_android/Services/location.dart';
import 'package:frontend_android/Handlers/Consulta/dialog_success_error_consulta.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class FormHandlersReport {
  final GlobalKey<FormState> formKey; // Clave global del formulario.
  final TextEditingController
      plateController; // Controlador de texto para la placa.
  final TextEditingController
      addressController; // Controlador de texto para la dirección.
  final Function(String) showSnackBar; // Función para mostrar una snackbar.
  final Function(String) showDialog; // Función para mostrar un diálogo.

  String? selectedVehicleType; // Tipo de vehículo seleccionado.
  String? selectedColor; // Color seleccionado.
  String? latitude; // Latitud obtenida.
  String? longitude; // Longitud obtenida.
  bool plateFieldTouched =
      false; // Indica si el campo de la placa ha sido tocado.
  bool addressFieldTouched =
      false; // Indica si el campo de la dirección ha sido tocado.
  bool vehicleTypeTouched =
      false; // Indica si el tipo de vehículo ha sido tocado.
  bool colorTouched = false; // Indica si el color ha sido tocado.
  bool isFormValid = false; // Indica si el formulario es válido.

  final Logger logger = Logger(); // Instancia para el registro de logs.
  final LocationService _locationService =
      LocationService(); // Instancia del servicio de ubicación.
  StreamSubscription<Position>?
      _positionStreamSubscription; // Suscripción al stream de posición.
  final StreamController<Position> _positionStreamController = StreamController<
      Position>.broadcast(); // Controlador del stream de posición.

  Stream<Position> get positionStream =>
      _positionStreamController.stream; // Stream de posición.

  // Constructor que inicializa los manejadores del formulario.
  FormHandlersReport({
    required this.formKey,
    required this.plateController,
    required this.addressController,
    required this.showSnackBar,
    required this.showDialog,
  });

  // Método para validar el formulario.
  void validateForm() {
    isFormValid = (formKey.currentState?.validate() ?? false) &&
        selectedVehicleType != null &&
        selectedColor != null &&
        plateController.text.isNotEmpty;
  }

  // Método para validar un campo específico del formulario.
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

  // Método para obtener la ubicación actual del usuario.
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

  // Método para empezar a escuchar la posición del usuario.
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

  // Método para liberar los recursos del controlador.
  void dispose() {
    _positionStreamSubscription?.cancel();
    _positionStreamController.close();
  }

  // Método para validar el formulario al enviar.
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

    validateForm(); // Valida todo el formulario.

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
