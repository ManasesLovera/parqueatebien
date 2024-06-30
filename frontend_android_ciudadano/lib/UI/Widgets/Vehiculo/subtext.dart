import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VehiculoSubText extends StatelessWidget {
  final String? sub;
  const VehiculoSubText({
    super.key,
    this.sub,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      sub ?? '',
      style: TextStyle(
        fontSize: 12.h,
        color: Colors.black,
        fontWeight: FontWeight.bold
      ),
    );
  }
}
