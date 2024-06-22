import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageReportConsult extends StatelessWidget {
  const ImageReportConsult({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Imagen(),
    );
  }
}

class Imagen extends StatelessWidget {
  const Imagen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/whiteback/main_w.png',
      height: 50.h,
    );
  }
}
