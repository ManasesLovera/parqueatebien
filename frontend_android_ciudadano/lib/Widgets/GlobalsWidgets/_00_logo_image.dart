import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomImageLogo extends StatelessWidget {
  final String? img;
  final int? altura;
  static final Image defaultImageb = Image.asset('assets/splash/main.png');
  static final Image defaultImagew = Image.asset('assets/whiteback/main_w.png');

  const CustomImageLogo({super.key, this.img, this.altura});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      img ?? '',
      height: (altura ?? 0).h,
    );
  }
}
