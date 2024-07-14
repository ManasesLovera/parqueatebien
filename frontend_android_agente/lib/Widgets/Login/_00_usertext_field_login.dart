// CEDULA CAMPO DE TEXTO
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Bloc/Login/login_cubit.dart';

class GovernmentIDTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController passController;

  const GovernmentIDTextField(
      {super.key, required this.controller, required this.passController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 1.h),
      child: SizedBox(
        height: 30.h,
        child: TextField(
          controller: controller,
          onChanged: (value) {
            context.read<LoginCubit>().updateButtonState(
                  controller.text,
                  passController.text,
                );
          },
          decoration: InputDecoration(
            hintText: 'Ingresar número de cédula',
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
          ),
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
