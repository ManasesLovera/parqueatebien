import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlateWidgetConsulta extends StatelessWidget {
  final TextEditingController controller;
  final bool touched;
  final FocusNode focusNode;
  final Function(String) onChanged;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40.h,
            child: TextFormField(
              style: const TextStyle(color: Colors.black),
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 14.h, vertical: 0.w),
                hintText: 'Ingresar Dígitos de la placa',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 10.h),
                filled: true,
                fillColor: Colors.white,
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
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                _PlateTextInputFormatter(),
                UpperCaseTextInputFormatter(),
                LengthLimitingTextInputFormatter(7),
              ],
              keyboardType: TextInputType.text,
              onChanged: onChanged,
            ),
          ),
          if (touched &&
              controller.text.isNotEmpty &&
              !RegExp(r'^[A-Z][0-9]{6}$').hasMatch(controller.text))
            Text(
              'La placa debe empezar con una letra mayúscula seguida de 6 números',
              style: TextStyle(color: Colors.red, fontSize: 10.h),
            ),
          if (touched && controller.text.isEmpty)
            Text(
              'Por favor ingrese un número de placa',
              style: TextStyle(color: Colors.red, fontSize: 10.h),
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
      return oldValue;
    }

    String formattedText =
        text.substring(0, 1).toUpperCase() + text.substring(1);
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
    final text = newValue.text.toUpperCase();
    return TextEditingValue(
      text: text,
      selection: newValue.selection,
    );
  }
}
