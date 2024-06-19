import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Usertext extends StatelessWidget {
  const Usertext({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 2.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Correo electronico',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.h,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
