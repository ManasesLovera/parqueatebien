import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginWidgets extends StatelessWidget {
  const LoginWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo/logo.png',
      height: 100.h,
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
        '¿Olvidaste la contraseña?',
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
