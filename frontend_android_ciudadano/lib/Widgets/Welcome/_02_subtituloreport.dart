import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubtituloReport extends StatelessWidget {
  final String? sub;
  const SubtituloReport({
    this.sub,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          sub ?? '',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13.h,
          ),
        ),
      ),
    );
  }
}
