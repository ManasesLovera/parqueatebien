import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/Login/ButtomLoginState/button_state_bloc.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/Login/ButtomLoginState/sign_in_bloc_builder.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/Login/LoginLogic/_02_login_bloc.dart';
import 'package:frontend_android_ciudadano/UI/Views/NuevoRegistro/_00.0_user.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/GlobalsWidgets/_00_logo_image.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/Login/_01_user_text_for_textfield_.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/Login/_05_forgot_password_tex.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/Login/_06_not_account_text.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/Login/_09_custom_registrate_now.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/NuevoRegistro/_01_custom_textfield_.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final iD = TextEditingController();
  final pass = TextEditingController();

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
                const CustomImageLogo(
                    img: 'assets/splash/main.png', altura: 100),
                SizedBox(height: 50.h),
                const Usertext(
                  text: 'Cedula',
                ),
                BlocProvider(
                  create: (_) => ButtonStateBloc(),
                  child: Builder(
                    builder: (context) {
                      iD.addListener(() {
                        context.read<ButtonStateBloc>().add(
                              TextChanged(iD.text, pass.text),
                            );
                      });
                      pass.addListener(() {
                        context.read<ButtonStateBloc>().add(
                              TextChanged(iD.text, pass.text),
                            );
                      });

                      return Column(
                        children: [
                          CustomTextField(
                            controller: iD,
                            hintText: 'Ingresar cedula',
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CedulaFormatterCedula(),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          const Usertext(
                            text: 'Contraseña',
                          ),
                          CustomTextField(
                            controller: pass,
                            hintText: 'Ingresar la contraseña',
                            obscureText: true,
                          ),
                          SizedBox(height: 16.h),
                          BlocProvider(
                            create: (_) => LoginBloc(),
                            child: SignInBlocBuilder(
                              iD: iD,
                              pass: pass,
                              role: 'Agente',
                            ),
                          ),
                          SizedBox(height: 15.h),
                          const ForgotPasswordText(
                            text: '¿Olvidaste tu Contraseña?',
                          ),
                          SizedBox(height: 80.h),
                          const DontAccount(
                            text: '¿No tienes una cuenta?',
                          ),
                          SizedBox(height: 8.h),
                          SizedBox(
                            child: RegisterNow(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RegisterUser(),
                                  ),
                                );
                              },
                              text: 'Registrarse ahora',
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CedulaFormatterCedula extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll('-', ''); // Remove existing dashes
    if (text.length > 11) {
      return oldValue; // Limit to 11 characters
    }

    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 3 || i == 10) {
        buffer.write('-');
      }
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: newValue.selection.copyWith(
        baseOffset: buffer.length,
        extentOffset: buffer.length,
      ),
    );
  }
}
