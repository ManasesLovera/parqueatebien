import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Custom Widgets for Login

class CustomImageLogoLogin extends StatelessWidget {
  final String img;
  final double altura;

  const CustomImageLogoLogin(
      {super.key, required this.img, required this.altura});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      img,
      height: altura,
    );
  }
}

class Usertext extends StatelessWidget {
  const Usertext({super.key, this.text});
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 2.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text ?? '',
          style: TextStyle(
            color: Colors.white,
            fontSize: 11.h,
          ),
        ),
      ),
    );
  }
}

class CustomTextFieldLogin extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFieldLogin({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
      inputFormatters: inputFormatters,
    );
  }
}

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({super.key, this.text});
  final String? text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Text(
        text ?? '',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.h,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class DontAccount extends StatelessWidget {
  const DontAccount({super.key, this.text});
  final String? text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Text(
        text ?? '',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.h,
        ),
      ),
    );
  }
}

class RegisterNow extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text;

  const RegisterNow({super.key, required this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return PaddingButton(onPressed: onPressed, text: text);
  }
}

class PaddingButton extends StatelessWidget {
  const PaddingButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      child: SizedBoxButton(onPressed: onPressed, text: text),
    );
  }
}

class SizedBoxButton extends StatelessWidget {
  const SizedBoxButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40.h,
      child: ContainerButton(onPressed: onPressed, text: text),
    );
  }
}

class ContainerButton extends StatelessWidget {
  const ContainerButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.white, width: 2.h),
      ),
      child: Button(onPressed: onPressed, text: text),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 9, 157, 210),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: TextForButton(text: text),
    );
  }
}

class TextForButton extends StatelessWidget {
  const TextForButton({
    super.key,
    required this.text,
  });

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: TextStyle(
        color: Colors.white,
        fontSize: 13.h,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class CedulaFormatterCedula extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll('-', ''); // Remove existing dashes
    if (text.length > 11) {
      return oldValue; // Limit to 11 characters
    }

    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 3 || i == 10) {
        buffer.write('-');
      }
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: newValue.selection.copyWith(
        baseOffset: buffer.length,
        extentOffset: buffer.length,
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isFilled;

  const SignInButton(
      {super.key, required this.onPressed, required this.isFilled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isFilled
                  ? [
                      const Color(0xFF010F56), // Color Azul Oscuro
                      const Color(0xFF010F56),
                    ]
                  : [
                      Colors.grey[100]!,
                      Colors.grey[200]!,
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 10.w),
            ),
            child: Text(
              'Ingresar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.h,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
