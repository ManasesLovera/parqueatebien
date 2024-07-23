import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_android_ciudadano/Blocs/NuevoUser/register_bloc.dart';
import 'package:frontend_android_ciudadano/Blocs/NuevoUser/register_event.dart';
import 'package:frontend_android_ciudadano/Handlers/User_vehicle_Register/dialog_success_error_cart.dart';
import 'package:frontend_android_ciudadano/Models/car_model.dart';
import 'package:frontend_android_ciudadano/Models/user_model.dart';
import 'package:frontend_android_ciudadano/Pages/_02_User_Login_Register_User_With_Vehicle/_00.1_car.dart';
import 'package:logger/logger.dart';

// Controlador para manejar el registro de vehículos
class RegisterCarController {
  final TextEditingController numplacaC = TextEditingController();
  final TextEditingController matriculaC = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  String? selectedYear;
  String? selectedColor;
  final ValueNotifier<bool> isButtonEnabled = ValueNotifier<bool>(false);
  final List<String> colors = ['Rojo', 'Azul', 'Verde', 'Negro', 'Blanco'];
  final List<String> years =
      List<String>.generate(124, (i) => (DateTime.now().year - i).toString());
  final Logger _logger = Logger();

  RegisterCarController() {
    numplacaC.addListener(updateButtonState);
    matriculaC.addListener(updateButtonState);
  }

  // Actualiza el estado del botón según los campos de entrada
  void updateButtonState() {
    isButtonEnabled.value = numplacaC.text.isNotEmpty ||
        modelController.text.isNotEmpty ||
        selectedYear != null ||
        selectedColor != null ||
        matriculaC.text.isNotEmpty;
  }

  // Valida los campos del formulario
  bool validateFields(BuildContext context) {
    if (numplacaC.text.isEmpty) {
      showUniversalSuccessErrorDialogCar(
          context, 'Campo requerido: Número de placa', false);
      return false;
    }
    if (!RegExp(r'^[A-Z]\d{6}$').hasMatch(numplacaC.text)) {
      showUniversalSuccessErrorDialogCar(
          context,
          'Número de placa debe iniciar con una letra seguida de 6 números',
          false);
      return false;
    }
    if (modelController.text.isEmpty) {
      showUniversalSuccessErrorDialogCar(
          context, 'Campo requerido: Marca', false);
      return false;
    }
    if (selectedYear == null) {
      showUniversalSuccessErrorDialogCar(
          context, 'Campo requerido: Año', false);
      return false;
    }
    if (selectedColor == null) {
      showUniversalSuccessErrorDialogCar(
          context, 'Campo requerido: Color', false);
      return false;
    }
    if (matriculaC.text.isEmpty) {
      showUniversalSuccessErrorDialogCar(
          context, 'Campo requerido: Matrícula', false);
      return false;
    }
    if (matriculaC.text.length != 9) {
      showUniversalSuccessErrorDialogCar(
          context, 'La matrícula debe tener 9 caracteres', false);
      return false;
    }
    return true;
  }

  // Registra el vehículo si los campos son válidos
  void register(BuildContext context, RegisterCar widget) {
    if (validateFields(context)) {
      final vehicle = Vehicle(
        governmentId: widget.governmentId,
        licensePlate: numplacaC.text,
        registrationDocument: matriculaC.text,
        model: modelController.text,
        year: selectedYear!,
        color: selectedColor!,
      );

      final user = User(
        governmentId: widget.governmentId,
        name: widget.name,
        lastname: widget.lastname,
        email: widget.email,
        password: widget.password,
        vehicles: [vehicle],
      );

      _logger.i('Request body: ${jsonEncode(user.toJson())}');

      context.read<RegisterBloc>().add(RegisterSubmitted(user));
    }
  }

  // Libera los controladores de texto
  void dispose() {
    numplacaC.dispose();
    matriculaC.dispose();
  }
}
