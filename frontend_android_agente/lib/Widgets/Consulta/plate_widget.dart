import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlateWidgetConsulta extends StatelessWidget {
  final TextEditingController controller; // Controlador del campo de texto.
  final bool touched; // Indica si el campo ha sido tocado.
  final FocusNode focusNode; // Nodo de foco del campo de texto.
  final Function(String)
      onChanged; // Función que se ejecuta cuando el texto cambia.

  const PlateWidgetConsulta({
    super.key,
    required this.controller,
    required this.touched,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.h),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Alineación a la izquierda.
        children: [
          SizedBox(
            height: 40.h, // Altura del campo de texto.
            child: TextFormField(
              style: const TextStyle(color: Colors.black), // Estilo del texto.
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 14.h, vertical: 0.w),
                hintText:
                    'Ingresar Dígitos de la placa A123456', // Texto de sugerencia.
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10.h), // Estilo del texto de sugerencia.
                filled: true,
                fillColor: Colors.white, // Color de fondo del campo de texto.
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-Z0-9]')), // Permite solo letras y números.
                _PlateTextInputFormatter(), // Formatea el texto de la placa.
                UpperCaseTextInputFormatter(), // Convierte el texto a mayúsculas.
                LengthLimitingTextInputFormatter(
                    7), // Limita la longitud del texto a 7 caracteres.
              ],
              keyboardType: TextInputType.text, // Tipo de teclado.
              onChanged:
                  onChanged, // Ejecuta la función cuando el texto cambia.
            ),
          ),
        ],
      ),
    );
  }
}

class _PlateTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    if (text.isEmpty) {
      return newValue;
    }

    final regExp = RegExp(r'^[a-zA-Z][0-9]{0,6}$');
    if (!regExp.hasMatch(text)) {
      return oldValue; // Devuelve el valor antiguo si el nuevo valor no coincide con el patrón.
    }

    String formattedText = text.substring(0, 1).toUpperCase() +
        text.substring(1); // Convierte el primer carácter a mayúscula.
    return newValue.copyWith(
      text: formattedText,
      selection: newValue.selection,
    );
  }
}

class UpperCaseTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text =
        newValue.text.toUpperCase(); // Convierte todo el texto a mayúsculas.
    return TextEditingValue(
      text: text,
      selection: newValue.selection,
    );
  }
}
