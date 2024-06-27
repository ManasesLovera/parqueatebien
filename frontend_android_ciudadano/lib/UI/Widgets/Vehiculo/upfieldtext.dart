import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Upfields extends StatelessWidget {
  final String? text;
  const Upfields({
    super.key,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: TextStyle(
        color: Colors.blue,
        fontSize: 11.h,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
