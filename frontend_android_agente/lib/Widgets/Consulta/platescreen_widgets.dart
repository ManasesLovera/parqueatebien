import 'package:flutter/services.dart';

class UpperCaseTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.toUpperCase();
    return TextEditingValue(
      text: text,
      selection: newValue.selection,
    );
  }
}

class PlateNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    final newText = text.length <= 1
        ? text.toUpperCase()
        : text.substring(0, 1).toUpperCase() +
            text.substring(1).replaceAll(RegExp(r'[^0-9]'), '');
    return TextEditingValue(
      text: newText,
      selection: newValue.selection,
    );
  }
}
