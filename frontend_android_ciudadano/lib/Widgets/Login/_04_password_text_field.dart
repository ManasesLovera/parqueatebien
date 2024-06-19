import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordTextField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 1.w),
      child: SizedBox(
        height: 32.h,
        child: TextField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.remove_red_eye_outlined,
              color: Colors.black,
              size: 20.h,
            ),
            hintText: 'Ingresar la contraseña',
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
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
