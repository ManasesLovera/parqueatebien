import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Handlers/Reportes/report_handler.dart';
const Color lightBlueColor = Color(0xFF009DD4); // Azul Claro
const Color darkBlueColor = Color(0xFF010F56); // Azul Oscuro
const Color greyTextColor = Color(0xFF494A4D); // Gris (Texto)

// Title Text Widget
class TitleText extends StatelessWidget {
  const TitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Nuevo reporte',
      style: TextStyle(
        fontSize: 22.h,
        fontWeight: FontWeight.bold,
        color: lightBlueColor,
      ),
    );
  }
}

// Datos del Vehiculo Text Widget
class DatosDelVehiculo extends StatelessWidget {
  const DatosDelVehiculo({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Datos del vehículo',
      style: TextStyle(
        fontSize: 14.h,
        fontWeight: FontWeight.bold,
        color: greyTextColor,
      ),
    );
  }
}

// Numero Placa Text Widget
class NumeroPlaca extends StatelessWidget {
  const NumeroPlaca({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Número de placa',
          style: TextStyle(
            color: const Color(0xFF010F56),
            fontSize: 10.h,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class PlateWidgetReport extends StatelessWidget {
  final TextEditingController controller;
  final bool touched;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final Function(String) validateField;

  const PlateWidgetReport({
    super.key,
    required this.controller,
    required this.touched,
    required this.focusNode,
    required this.onChanged,
    required this.validateField,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 0.w),
      child: SizedBox(
        height: 30.h,
        child: TextFormField(
          style: const TextStyle(color: Colors.black),
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.w, horizontal: 8.h),
            hintText: 'Ingrese número',
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
          ],
          keyboardType: TextInputType.text,
          onChanged: onChanged,
          onEditingComplete: () {
            validateField('plate');
          },
        ),
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

// Tipo de Vehiculo Text Widget
class TipoDeVehiculo extends StatelessWidget {
  const TipoDeVehiculo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Tipo de vehículo',
          style: TextStyle(
            color: const Color(0xFF010F56),
            fontSize: 10.h,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class VehicleTypeWidget extends StatelessWidget {
  final String? selectedValue;
  final FocusNode focusNode;
  final Function(String?) onChanged;
  final bool touched;
  final Function() onValidate;
  final Function(String) validateField;

  const VehicleTypeWidget({
    super.key,
    required this.selectedValue,
    required this.focusNode,
    required this.onChanged,
    required this.touched,
    required this.onValidate,
    required this.validateField,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h),
      child: SizedBox(
        height: 35.h,
        child: DropdownButtonFormField<String>(
          focusNode: focusNode,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 8.w, horizontal: 8.h),
            isDense: true,
            hintText: 'Seleccionar',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 10.h),
            filled: true,
            fillColor: const Color(0xFFFFFFFF),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              borderSide: const BorderSide(color: Colors.black),
            ),
          ),
          dropdownColor: const Color(0xFFFFFFFF),
          items:
              <String>['Automóvil', 'Motor', 'Bicicleta'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// Tipo de Vehiculo Text Widget
class ColorReporte extends StatelessWidget {
  const ColorReporte({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Color',
          style: TextStyle(
            color: const Color(0xFF010F56),
            fontSize: 10.h,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ColorWidget extends StatelessWidget {
  final String? selectedValue;
  final FocusNode focusNode;
  final Function(String?) onChanged;
  final bool touched;
  final Function() onValidate;
  final Function(String) validateField;

  const ColorWidget({
    super.key,
    required this.selectedValue,
    required this.focusNode,
    required this.onChanged,
    required this.touched,
    required this.onValidate,
    required this.validateField,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h),
      child: SizedBox(
        height: 35.h,
        child: DropdownButtonFormField<String>(
          focusNode: focusNode,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 8.w, horizontal: 8.h),
            isDense: true,
            hintText: 'Seleccionar',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 10.h),
            filled: true,
            fillColor: const Color(0xFFFFFFFF),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              borderSide: const BorderSide(color: Colors.black),
            ),
          ),
          dropdownColor: const Color(0xFFFFFFFF),
          items:
              <String>['Rojo', 'Azul', 'Negro', 'Blanco'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// Referencia Text Widget
class Referencia extends StatelessWidget {
  const Referencia({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Referencia (Opcional)',
          style: TextStyle(
            color: const Color(0xFF010F56),
            fontSize: 10.h,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Address Widget
class AddressWidget extends StatefulWidget {
  final TextEditingController controller;
  final bool touched;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final Function() onValidate;

  const AddressWidget({
    super.key,
    required this.controller,
    required this.touched,
    required this.focusNode,
    required this.onChanged,
    required this.onValidate,
  });

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h),
      child: SizedBox(
        height: 30.h,
        child: TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.h),
            hintText: 'Ingresar',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 10.h),
            filled: true,
            fillColor: Colors.white,
            isDense: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              borderSide: const BorderSide(color: Colors.black),
            ),
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}

// Down Text Vehiculo Text Widget
class DownTextVehiculoText extends StatelessWidget {
  const DownTextVehiculoText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        'Referencia donde el vehículo está mal parqueado',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 10.h,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Siguiente Text Widget
class SiguienteText extends StatelessWidget {
  const SiguienteText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Siguiente',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.h,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required FormHandlersReport formHandlers,
    required VoidCallback onValidate,
  })  : _formHandlers = formHandlers,
        _onValidate = onValidate;

  final FormHandlersReport _formHandlers;
  final VoidCallback _onValidate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 0.w),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            _onValidate();
            _formHandlers.validateOnSubmit(context);
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            backgroundColor: _formHandlers.isFormValid
                ? const Color(0xFF010F56)
                : Colors.grey[400],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.h),
            ),
          ),
          child: const SiguienteText(),
        ),
      ),
    );
  }
}
