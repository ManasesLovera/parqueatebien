import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClasLoginText extends StatelessWidget {
  final String text;

  const ClasLoginText({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
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
