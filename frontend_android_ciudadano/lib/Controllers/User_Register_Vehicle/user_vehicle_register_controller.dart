import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_android_ciudadano/Handlers/Login/dialog_success_error_user.dart';

class RegisterUserController {
  final TextEditingController cedulaC = TextEditingController();
  final TextEditingController nombresC = TextEditingController();
  final TextEditingController apellidosC = TextEditingController();
  final TextEditingController correoC = TextEditingController();
  final TextEditingController passC = TextEditingController();
  final TextEditingController confirmPassC = TextEditingController();
  final ValueNotifier<bool> isButtonEnabled = ValueNotifier<bool>(false);

  bool obscureText = true;
  final double progress = 50;

  RegisterUserController() {
    cedulaC.addListener(_updateButtonState);
    nombresC.addListener(_updateButtonState);
    apellidosC.addListener(_updateButtonState);
    correoC.addListener(_updateButtonState);
    passC.addListener(_updateButtonState);
    confirmPassC.addListener(_updateButtonState);
  }

 void _updateButtonState() {
    isButtonEnabled.value = cedulaC.text.isNotEmpty ||
        nombresC.text.isNotEmpty ||
        apellidosC.text.isNotEmpty ||
        correoC.text.isNotEmpty ||
        passC.text.isNotEmpty ||
        confirmPassC.text.isNotEmpty;
  }

bool validateFields(BuildContext context) {
    String formattedCedula = cedulaC.text.replaceAll('-', '');

    if (cedulaC.text.isEmpty) {
      showUniversalSuccessErrorDialog(
          context, 'Campo requerido: Cédula', false);
      return false;
    }
    if (formattedCedula.length != 11) {
      showUniversalSuccessErrorDialog(
          context, 'Cédula incompleta. Debe tener 11 dígitos.', false);
      return false;
    }
    if (nombresC.text.isEmpty) {
      showUniversalSuccessErrorDialog(
          context, 'Campo requerido: Nombres', false);
      return false;
    }
    if (apellidosC.text.isEmpty) {
      showUniversalSuccessErrorDialog(
          context, 'Campo requerido: Apellidos', false);
      return false;
    }
    if (correoC.text.isEmpty) {
      showUniversalSuccessErrorDialog(
          context, 'Campo requerido: Correo', false);
      return false;
    }
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(correoC.text)) {
      showUniversalSuccessErrorDialog(
          context, 'Por favor, ingrese un correo válido', false);
      return false;
    }
    if (passC.text.isEmpty) {
      showUniversalSuccessErrorDialog(
          context, 'Campo requerido: Contraseña', false);
      return false;
    }
    if (passC.text.length < 8) {
      showUniversalSuccessErrorDialog(
          context, 'La contraseña debe tener al menos 8 caracteres', false);
      return false;
    }
    if (confirmPassC.text.isEmpty) {
      showUniversalSuccessErrorDialog(
          context, 'Campo requerido: Confirmar contraseña', false);
      return false;
    }
    if (passC.text != confirmPassC.text) {
      showUniversalSuccessErrorDialog(
          context, 'Las contraseñas no coinciden', false);
      return false;
    }
    return true;
  }

  void dispose() {
    cedulaC.dispose();
    nombresC.dispose();
    apellidosC.dispose();
    correoC.dispose();
    passC.dispose();
    confirmPassC.dispose();
  }
}

class CedulaFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll('-', ''); // Remove existing dashes
    if (text.length > 11) {
      return oldValue; // Limit to 11 characters
    }

    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 3 || i == 10) {
        buffer.write('-');
      }
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: newValue.selection.copyWith(
        baseOffset: buffer.length,
        extentOffset: buffer.length,
      ),
    );
  }
}
