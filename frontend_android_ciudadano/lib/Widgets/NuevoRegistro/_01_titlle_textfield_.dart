import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Color lightBlueColor = Color(0xFF009DD4); // Azul Claro
const Color darkBlueColor = Color(0xFF010F56); // Azul Oscuro
const Color greyTextColor = Color(0xFF494A4D); // Gris (Texto)

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  const CustomText({
    super.key,
    required this.text,
    this.color = darkBlueColor,
    this.fontSize = 11.0,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 2.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: fontSize.h,
            fontWeight: fontWeight,
          ),
          textAlign: textAlign,
        ),
      ),
    );
  }
}
