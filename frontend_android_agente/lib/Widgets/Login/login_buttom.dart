import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClasLoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isFilled;

  const ClasLoginButton(
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
                      const Color(0xFFF26522), // Color Azul Oscuro
                      const Color(0xFFF26522),
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
