import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Bloc/Login/login_buttom_login_cubit.dart';
import 'package:frontend_android/Handlers/Login/login_handler.dart';
import 'package:frontend_android/Widgets/Login/login_buttom.dart';
import 'package:frontend_android/Widgets/Login/login_general_widgets.dart';
import 'package:frontend_android/Widgets/Login/login_text_and_textfields_components.dart';

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
            create: (context) => ClassLoginCubit(),
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
                        ClassUserPassTextAndTextfieldToo(
                          label: 'Usuario',
                          controller: iD,
                          otherController: pass,
                          hintText: 'Ingrese usuario',
                        ),
                        ClassUserPassTextAndTextfieldToo(
                          label: 'Contraseña',
                          controller: pass,
                          otherController: iD,
                          hintText: 'Ingresar la contraseña',
                          obscureText: true,
                          suffixIcon: const Icon(Icons.remove_red_eye),
                          inputFormatters: const [],
                        ),
                        BlocBuilder<ClassLoginCubit, bool>(
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
