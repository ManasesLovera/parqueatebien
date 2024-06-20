import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GovernmentIDTextField extends StatelessWidget {
  final TextEditingController controller;

  const GovernmentIDTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 1.w),
      child: SizedBox(
        height: 32.h,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Ingresar correo electronico',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 11.h),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.r)),
             borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.r)),
          borderSide: const BorderSide(color: Colors.transparent),
            ),
          ),
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
