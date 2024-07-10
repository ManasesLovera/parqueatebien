import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Downfield extends StatelessWidget {
  final Map<String, dynamic> details;
  final String detailKey;

  const Downfield({
    super.key,
    required this.details,
    required this.detailKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          details[detailKey] ?? '',
          style: TextStyle(
            fontSize: 10.h,
            color: Colors.grey
          ),
        ),
      ],
    );
  }
}
