import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key, required String role});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.h),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          'Bienvenido',
          style: TextStyle(
            color: const Color(0xFFF26522),
            fontSize: 26.h,
          ),
        ),
      ),
    );
  }
}
