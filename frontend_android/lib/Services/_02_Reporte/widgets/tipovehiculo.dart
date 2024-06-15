import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TipodeVehiculo extends StatelessWidget {
  const TipodeVehiculo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Tipo de vehiculo',
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
