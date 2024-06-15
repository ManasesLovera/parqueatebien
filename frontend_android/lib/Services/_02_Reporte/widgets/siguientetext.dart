import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SiguienteText extends StatelessWidget {
  const SiguienteText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Siguiente',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.h,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
