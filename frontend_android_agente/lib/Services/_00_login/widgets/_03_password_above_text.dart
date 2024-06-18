import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
