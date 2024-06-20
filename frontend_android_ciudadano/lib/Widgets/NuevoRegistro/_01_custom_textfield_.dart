import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Color fillColor;
  final Color hintTextColor;
  final Color textColor;
  final double fontSize;
  final double borderRadius;
  final Color borderColor;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.fillColor = Colors.white,
    this.hintTextColor = Colors.grey,
    this.textColor = Colors.grey,
    this.fontSize = 11.0,
    this.borderRadius = 7.0,
    this.borderColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 1.w),
      child: SizedBox(
        height: 32.h,
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: hintTextColor, fontSize: fontSize.h),
            filled: true,
            fillColor: fillColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius.r)),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius.r)),
              borderSide: BorderSide(color: borderColor),
            ),
          ),
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
