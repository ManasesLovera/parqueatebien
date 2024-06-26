import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SatusButtom extends StatelessWidget {
  const SatusButtom({
    super.key,
    required this.details,
  });

  final Map<String, dynamic> details;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(details['Status'],
            style: TextStyle(color: Colors.white, fontSize: 10.h)),
      ),
    );
  }
}
