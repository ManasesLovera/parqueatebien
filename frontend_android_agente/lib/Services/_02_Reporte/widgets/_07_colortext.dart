import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorText extends StatelessWidget {
  const ColorText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Color',
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 10.h,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}