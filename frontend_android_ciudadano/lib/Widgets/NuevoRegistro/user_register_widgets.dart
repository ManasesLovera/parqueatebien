import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarRegister extends StatelessWidget implements PreferredSizeWidget {
  final double progress;

  const AppBarRegister({
    super.key,
    this.progress = 0.0, // Valor por defecto para el progreso
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text(
            'Nuevo Registro',
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            icon: SizedBox(
              height: 24.h, // Ajusta el tamaño aquí si es necesario
              child: SvgPicture.asset('assets/icons/back.svg'),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Stack(
          children: [
            const Divider(
              height: 2,
              color: Colors.grey,
            ),
            Positioned(
              left: 0,
              child: Container(
                width: progress,
                height: 3,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight + 2); // Ajusta el tamaño preferido para incluir la línea
}

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
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;

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
    this.inputFormatters,
    this.suffixIcon,
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
          obscuringCharacter: '*',
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
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
            suffixIcon: suffixIcon,
          ),
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}

const Color darkBlueColor = Color(0xFF010F56); // Azul Oscuro

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

const Color greyTextColor = Color(0xFF494A4D); // Gris (Texto)

class RegistroButtom extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final bool isEnabled;

  const RegistroButtom({
    super.key,
    required this.onPressed,
    this.isEnabled = false,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 4.w),
      child: SizedBox(
        width: double.infinity,
        height: 40.h,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isEnabled
                  ? [darkBlueColor, darkBlueColor]
                  : [Colors.grey[300]!, Colors.grey[400]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(7.r),
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.r),
              ),
            ),
            child: Text(
              text ?? '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.h,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
