import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NumeroPlaca extends StatelessWidget {
  const NumeroPlaca({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Numero de placa',
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
