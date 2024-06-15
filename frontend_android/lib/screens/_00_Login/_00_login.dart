import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Services/_00_login/Handle/__handle_sign_in.dart';
import 'package:frontend_android/Services/_00_login/widgets/_00_main_image.dart';
import 'package:frontend_android/Services/_00_login/widgets/_01_user_above_text_.dart';
import 'package:frontend_android/Services/_00_login/widgets/_02_government_id_text_field.dart';
import 'package:frontend_android/Services/_00_login/widgets/_03_password_above_text.dart';
import 'package:frontend_android/Services/_00_login/widgets/_04_password_text_field.dart';
import 'package:frontend_android/Services/_00_login/widgets/_05_sign_in_button.dart';
import 'package:frontend_android/Services/_00_login/widgets/_06_forgot_password_text.dart';
import 'package:frontend_android/Services/_00_login/widgets/_07_bottom_image.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _iD = TextEditingController();
  final _pass = TextEditingController();

  @override
  void dispose() {
    _iD.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                GovernmentIDTextField(controller: _iD),
                SizedBox(height: 20.h),
                const Passwordtext(),
                PasswordTextField(controller: _pass),
                SizedBox(height: 16.h),
                SignInButton(onPressed: () => sign(context, _iD, _pass)),
                SizedBox(height: 20.h),
                const ForgotPasswordText(),
                SizedBox(height: 140.h),
                const BottomImage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
