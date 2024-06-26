import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Widgets/GlobalsWidgets/_00_logo_image.dart';

class CarDetails extends StatelessWidget {
  const CarDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: Column(
          children: [
            SizedBox(height: 30.h),
            const Center(
                child: CustomImageLogo(
                    img: 'assets/whiteback/main_w.png', altura: 60)),
          ],
        ),
      ))),
    );
  }
}
