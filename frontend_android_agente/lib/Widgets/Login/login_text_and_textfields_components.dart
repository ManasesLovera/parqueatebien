import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Bloc/Login/login_buttom_login_cubit.dart';

class ClassUserPassTextAndTextfieldToo extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextEditingController otherController;
  final String hintText;
  final bool obscureText;
  final Icon? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;

  const ClassUserPassTextAndTextfieldToo({
    super.key,
    required this.label,
    required this.controller,
    required this.otherController,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.h,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.h),
          SizedBox(
            height: 30.h,
            child: TextField(
              controller: controller,
              onChanged: (value) {
                context.read<ClassLoginCubit>().methodupdateButtonState(
                      controller.text,
                      otherController.text,
                    );
              },
              obscureText: obscureText,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 10.h),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  borderSide: const BorderSide(color: Colors.white70),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                suffixIcon: suffixIcon,
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
