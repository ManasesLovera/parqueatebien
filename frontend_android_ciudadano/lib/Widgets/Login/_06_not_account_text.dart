import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DontAccount extends StatelessWidget {
  const  DontAccount({super.key, this.text});
  final String? text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/forgot');
      },
      child: Text(
      text ??'',
       //¿No tienes una cuenta?
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.h,
          // fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
