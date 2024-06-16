import 'package:frontend_android/Services/_02_Reporte/handlers/form_handlers.dart';

class FormController {
  final FormHandlers handlers;

  FormController({
    required this.handlers,
  });

  void init() {
    handlers.plateController.addListener(handlers.validateForm);
    handlers.addressController.addListener(handlers.validateForm);
    handlers.getLocation();
  }

  void dispose() {
    handlers.plateController.dispose();
    handlers.addressController.dispose();
  }
}
