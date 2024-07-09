import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DownTextVehiculoText extends StatelessWidget {
  const DownTextVehiculoText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        'Referencia donde el vehículo está mal parqueado',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 10.h,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
