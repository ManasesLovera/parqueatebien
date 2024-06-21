import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubtituloReport extends StatelessWidget {
  const SubtituloReport({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          '¿Que deseas realizar hoy?',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13.h,
          ),
        ),
      ),
    );
  }
}
