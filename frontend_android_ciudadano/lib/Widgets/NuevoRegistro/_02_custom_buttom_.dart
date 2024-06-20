import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistroButtom extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isEnabled;

  const RegistroButtom({
    required this.onPressed,
    this.isEnabled = false,
    super.key,
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
                  ? [Colors.grey[500]!, Colors.blue[500]!]
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
              'Siguiente',
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
