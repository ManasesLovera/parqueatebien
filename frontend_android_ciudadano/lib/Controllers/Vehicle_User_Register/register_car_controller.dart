import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend_android_ciudadano/Handlers/User_vehicle_Register/dialog_success_error_car_new.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_android_ciudadano/Blocs/Vehicle_New_Add/new_vehicle_registration_bloc.dart';
import 'package:frontend_android_ciudadano/Blocs/Vehicle_New_Add/new_vehicle_registration_event.dart';

class NewRegisterCarController {
  final ValueNotifier<bool> isButtonEnabled = ValueNotifier<bool>(false);
  final TextEditingController numplacaC = TextEditingController();
  final TextEditingController matriculaC = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  String? selectedYear;
  String? selectedColor;
  final List<String> colors = ['Rojo', 'Azul', 'Verde', 'Negro', 'Blanco'];
  final List<String> years =
      List<String>.generate(124, (i) => (DateTime.now().year - i).toString());
  final Logger _logger = Logger();

  NewRegisterCarController() {
    numplacaC.addListener(updateButtonStateNew);
    matriculaC.addListener(updateButtonStateNew);
  }

  void updateButtonStateNew() {
    isButtonEnabled.value = numplacaC.text.isNotEmpty &&
        modelController.text.isNotEmpty &&
        selectedYear != null &&
        selectedColor != null &&
        matriculaC.text.isNotEmpty;
  }

  bool validateFieldsNew(BuildContext context) {
    if (numplacaC.text.isEmpty) {
      showUniversalSuccessErrorDialogCarNewNew(
          context, 'Campo requerido: Número de placa', false);
      return false;
    }
    if (!RegExp(r'^[A-Z]\d{6}$').hasMatch(numplacaC.text)) {
      showUniversalSuccessErrorDialogCarNewNew(
          context,
          'Número de placa debe iniciar con una letra seguida de 6 números',
          false);
      return false;
    }
    if (modelController.text.isEmpty) {
      showUniversalSuccessErrorDialogCarNewNew(
          context, 'Campo requerido: Modelo', false);
      return false;
    }
    if (selectedYear == null) {
      showUniversalSuccessErrorDialogCarNewNew(
          context, 'Campo requerido: Año', false);
      return false;
    }
    if (selectedColor == null) {
      showUniversalSuccessErrorDialogCarNewNew(
          context, 'Campo requerido: Color', false);
      return false;
    }
    if (matriculaC.text.isEmpty) {
      showUniversalSuccessErrorDialogCarNewNew(
          context, 'Campo requerido: Matrícula', false);
      return false;
    }
    if (matriculaC.text.length != 9) {
      showUniversalSuccessErrorDialogCarNewNew(
          context, 'La matrícula debe tener 9 caracteres', false);
      return false;
    }
    return true;
  }

  void registerNew(BuildContext context) async {
    if (validateFieldsNew(context)) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final governmentId = prefs.getString('governmentId') ?? '';

      context.read<NewVehicleRegistrationBloc>().add(RegisterNewVehicle(
            governmentId: governmentId,
            licensePlate: numplacaC.text,
            vehicleType: 'Car',
            vehicleColor: selectedColor!,
            model: modelController.text,
            year: selectedYear!,
            matricula: matriculaC.text,
          ));
      _logger.i('Request body: ${jsonEncode({
            'governmentId': governmentId,
            'licensePlate': numplacaC.text,
            'vehicleType': 'Car',
            'vehicleColor': selectedColor!,
            'model': modelController.text,
            'year': selectedYear!,
            'matricula': matriculaC.text,
          })}');
    }
  }

  void dispose() {
    numplacaC.dispose();
    matriculaC.dispose();
    modelController.dispose();
  }
}
