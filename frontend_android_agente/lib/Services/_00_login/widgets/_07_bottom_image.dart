import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomImage extends StatelessWidget {
  const BottomImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/splash/bottom.png',
      height: 50.h,
    );
  }
}
