import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterNow extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text;

  const RegisterNow({super.key, required this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return PaddingButtom(onPressed: onPressed, text: text);
  }
}

class PaddingButtom extends StatelessWidget {
  const PaddingButtom({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      child: SizeBoxButtom(onPressed: onPressed, text: text),
    );
  }
}

class SizeBoxButtom extends StatelessWidget {
  const SizeBoxButtom({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40.h,
      child: ContainerButtom(onPressed: onPressed, text: text),
    );
  }
}

class ContainerButtom extends StatelessWidget {
  const ContainerButtom({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.white, width: 2.h),
      ),
      child: Buttom(onPressed: onPressed, text: text),
    );
  }
}

class Buttom extends StatelessWidget {
  const Buttom({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 9, 157, 210),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: TextForButtom(text: text),
    );
  }
}

class TextForButtom extends StatelessWidget {
  const TextForButtom({
    super.key,
    required this.text,
  });

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: TextStyle(
        color: Colors.white,
        fontSize: 13.h,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
