import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorWidget extends StatelessWidget {
  final String? selectedValue;
  final FocusNode focusNode;
  final Function(String?) onChanged;
  final bool touched;
  final Function() onValidate;

  const ColorWidget({
    super.key,
    required this.selectedValue,
    required this.focusNode,
    required this.onChanged,
    required this.touched,
    required this.onValidate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30.h,
            child: DropdownButtonFormField<String>(
              focusNode: focusNode,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.w, horizontal: 8.h),
                isDense: true,
                hintText: 'Seleccionar',
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
              items: <String>['Rojo', 'Azul', 'Negro', 'Blanco']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
          if (touched && selectedValue == null)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.w),
              child: Text(
                'Seleccione un color',
                style: TextStyle(color: Colors.red, fontSize: 10.h),
              ),
            ),
        ],
      ),
    );
  }
}
