import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ReportConsultButtom extends StatelessWidget {
  final String svgPath;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ReportConsultButtom({
    super.key,
    required this.svgPath,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Button(onTap: onTap, svgPath: svgPath, title: title, subtitle: subtitle);
  }
}

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onTap,
    required this.svgPath,
    required this.title,
    required this.subtitle,
  });

  final VoidCallback onTap;
  final String svgPath;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 6.h),
        child: Container(
          padding: EdgeInsets.all(8.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2.h),
            borderRadius: BorderRadius.circular(12.h),
          ),
          child: Rouw(svgPath: svgPath, title: title, subtitle: subtitle),
        ),
      ),
    );
  }
}

class Rouw extends StatelessWidget {
  const Rouw({
    super.key,
    required this.svgPath,
    required this.title,
    required this.subtitle,
  });

  final String svgPath;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Svg(svgPath: svgPath),
        SizedBox(height: 50.h, width: 8.h),
        Expand(title: title, subtitle: subtitle),
      ],
    );
  }
}

class Expand extends StatelessWidget {
  const Expand({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Colum(title: title, subtitle: subtitle),
    );
  }
}

class Colum extends StatelessWidget {
  const Colum({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
    
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TittleText(title: title),
        SubtitleText(subtitle: subtitle),
      ],
    );
  }
}

class Svg extends StatelessWidget {
  const Svg({
    super.key,
    required this.svgPath,
  });

  final String svgPath;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(svgPath, height: 25.h);
  }
}

class TittleText extends StatelessWidget {
  const TittleText({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14.h,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }
}

class SubtitleText extends StatelessWidget {
  const SubtitleText({
    super.key,
    required this.subtitle,
  });

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      style: TextStyle(
        fontSize: 9.h,
        color: Colors.grey[600],
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
