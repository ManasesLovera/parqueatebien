import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
const Color lightBlueColor = Color(0xFF009DD4); // Azul Claro
const Color darkBlueColor = Color(0xFF010F56); // Azul Oscuro
const Color greyTextColor = Color(0xFF494A4D); // Gris (Texto)
class SubtituloReport extends StatelessWidget {
  const SubtituloReport({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          '¿Que deseas realizar hoy?',
          style: TextStyle(
            color: greyTextColor ,
            fontSize: 13.h,
          ),
        ),
      ),
    );
  }
}
