import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Upfields extends StatelessWidget {
  final String? text;
  const Upfields({
    super.key, this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ??'',
      style: TextStyle(
        fontSize: 11.h,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
