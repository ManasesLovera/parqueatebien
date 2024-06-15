import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DatosdelVehiculo extends StatelessWidget {
  const DatosdelVehiculo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Datos del vehículo',
      style: TextStyle(
        fontSize: 14.h,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
    );
  }
}
