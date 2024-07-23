import 'package:flutter/material.dart';
import 'package:frontend_android/Handlers/Reportes/report_handler.dart';

class FormControllerReport {
  final FormHandlersReport
      handlers; // Instancia de los manejadores de formularios.

  // Constructor que recibe los manejadores de formularios.
  FormControllerReport({
    required this.handlers,
  });

  // Método para inicializar los controladores y obtener la ubicación.
  void init(BuildContext context) {
    handlers.plateController.addListener(
        handlers.validateForm); // Añade un listener al controlador de la placa.
    handlers.addressController.addListener(handlers
        .validateForm); // Añade un listener al controlador de la dirección.
    handlers.getLocation(context); // Obtiene la ubicación y pasa el contexto.
  }

  // Método para liberar los recursos de los controladores.
  void dispose() {
    handlers.plateController.dispose(); // Libera el controlador de la placa.
    handlers.addressController
        .dispose(); // Libera el controlador de la dirección.
  }
}
