import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Blocs/_02_login_bloc.dart';
import 'package:frontend_android_ciudadano/Widgets/Login/_01_user_above_text_.dart';
import 'package:frontend_android_ciudadano/Widgets/Login/_00_main_image.dart';
import 'package:frontend_android_ciudadano/Widgets/Login/_02_government_id_text_field.dart';
import 'package:frontend_android_ciudadano/Widgets/Login/_03_password_above_text.dart';
import 'package:frontend_android_ciudadano/Widgets/Login/_04_password_text_field.dart';
import 'package:frontend_android_ciudadano/Widgets/Login/_06_forgot_password_text.dart';
import 'package:frontend_android_ciudadano/Widgets/Login/_07_bottom_image.dart';
import 'package:frontend_android_ciudadano/Widgets/Login/_08_sign_in_bloc_builder.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController iD = TextEditingController();
  final TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 9, 157, 210),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50.h),
                const MainImage(),
                SizedBox(height: 50.h),
                const Usertext(),
                GovernmentIDTextField(
                  controller: iD,
                ),
                SizedBox(height: 20.h),
                const Passwordtext(),
                PasswordTextField(
                  controller: pass,
                ),
                SizedBox(height: 16.h),
                SignInBlocBuilder(
                  iD: iD,
                  pass: pass,
                ),
                SizedBox(height: 20.h),
                const ForgotPasswordText(),
                SizedBox(height: 140.h),
                const BottomImage(),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
