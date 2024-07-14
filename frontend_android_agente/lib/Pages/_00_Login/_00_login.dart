import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Bloc/Login/login_cubit.dart';
import 'package:frontend_android/Handlers/Login/sign_handler.dart';
import 'package:frontend_android/Widgets/Login/_01_passtextfield_login.dart';
import 'package:frontend_android/Widgets/Login/_00_usertext_field_login.dart';
import 'package:frontend_android/Widgets/Login/_02_buttom_login.dart';
import 'package:frontend_android/Widgets/Login/general_widgets_login.dart';
import 'package:frontend_android/Widgets/Login/login_texts.dart';

class ClassPageLogin extends StatelessWidget {
  const ClassPageLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final iD = TextEditingController();
    final pass = TextEditingController();
    const String role = 'Agente';
    return
        //
        BlocProvider(
            create: (context) => LoginCubit(),
            //
            child: Scaffold(
              backgroundColor: const Color.fromARGB(255, 9, 157, 210),
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 50.h),
                        const LoginWidgets(),
                        SizedBox(height: 50.h),
                        const ClasLoginText(text: 'Cedula'),
                        GovernmentIDTextField(
                            controller: iD, passController: iD),
                        SizedBox(height: 20.h),
                        const ClasLoginText(text: 'Contraseña'),
                        PasswordTextField(controller: pass, idController: pass),
                        SizedBox(height: 16.h),
                        BlocBuilder<LoginCubit, bool>(
                          builder: (context, isFilled) {
                            return ClasLoginButton(
                                onPressed: isFilled
                                    ? () => methodHandlerLoginFuture(
                                        context, iD, pass, role)
                                    : null,
                                isFilled: isFilled);
                          },
                        ),
                        SizedBox(height: 20.h),
                        const ForgotPasswordText(),
                        SizedBox(height: 140.h),
                        const BottomImage()
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
