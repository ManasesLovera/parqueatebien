import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginWidgets extends StatelessWidget {
  const LoginWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/splash/main.png',
      height: 100.h,
    );
  }
}

class Usertext extends StatelessWidget {
  const Usertext({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Usuario',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10.h,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

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

class Passwordtext extends StatelessWidget {
  const Passwordtext({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Password',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10.h,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 1.h),
      child: SizedBox(
        height: 30.h,
        child: TextField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.remove_red_eye),
            hintText: 'Ingresar la contraseña',
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

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/forgot');
      },
      child: Text(
        '¿Olvidaste La Contraseña?',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.h,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class BottomImage extends StatelessWidget {
  const BottomImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/splash/bottom.png',
      height: 50.h,
    );
  }
}
