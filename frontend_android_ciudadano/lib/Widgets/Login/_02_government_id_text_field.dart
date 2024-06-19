import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GovernmentIDTextField extends StatelessWidget {
  final TextEditingController controller;

  const GovernmentIDTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 1.h),
      child: SizedBox(
        height: 30.h,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Ingresar número de cédula',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 10.h),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              borderSide: const BorderSide(color: Colors.white70),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              borderSide: const BorderSide(color: Colors.white),
            ),
          ),
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
