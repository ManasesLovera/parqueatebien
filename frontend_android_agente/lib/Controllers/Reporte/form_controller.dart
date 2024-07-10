import 'package:flutter/material.dart';
import 'package:frontend_android/Handlers/Reportes/report_handler.dart';

class FormControllerReport {
  final FormHandlersReport handlers;

  FormControllerReport({
    required this.handlers,
  });

  void init(BuildContext context) {
    handlers.plateController.addListener(handlers.validateForm);
    handlers.addressController.addListener(handlers.validateForm);
    handlers.getLocation(context); // Pasa el contexto aquí
  }

  void dispose() {
    handlers.plateController.dispose();
    handlers.addressController.dispose();
  }
}
