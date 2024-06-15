import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TittleText extends StatelessWidget {
  const TittleText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Nuevo reporte',
      style: TextStyle(
        fontSize: 22.h,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }
}
