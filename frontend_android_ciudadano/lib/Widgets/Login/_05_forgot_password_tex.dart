import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({super.key, this.text});
  final String? text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/forgot');
      },
      child: Text(
       text?? '',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.h,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
