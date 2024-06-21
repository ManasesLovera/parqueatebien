import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
           text??'',
          style: TextStyle(
            color: Colors.white,
            fontSize: 11.h,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
