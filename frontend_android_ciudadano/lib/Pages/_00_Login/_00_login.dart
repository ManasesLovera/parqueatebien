import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Handlers/Login/sigin_handler.dart';
import 'package:frontend_android_ciudadano/Pages/_02_User_Login_Register_User_With_Vehicle/_00.0_user.dart';
import 'package:frontend_android_ciudadano/Widgets/Login/login_widgets.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/_01_custom_textfield_.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  final _iD = TextEditingController();
  final _pass = TextEditingController();
  bool obscureText = true;
  final ValueNotifier<bool> _isFilled = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _iD.addListener(_updateButtonState);
    _pass.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    _isFilled.value = _iD.text.isNotEmpty && _pass.text.isNotEmpty;
  }

  @override
  void dispose() {
    _iD.removeListener(_updateButtonState);
    _pass.removeListener(_updateButtonState);
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
                const CustomImageLogoLogin(
                    img: 'assets/splash/main.png', altura: 100),
                SizedBox(height: 50.h),
                const Usertext(
                  text: 'Cedula',
                ),
                Column(
                  children: [
                    CustomTextField(
                      controller: _iD,
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
                      controller: _pass,
                      hintText: 'Ingresar la contraseña',
                      obscureText: obscureText,
                      //
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ValueListenableBuilder<bool>(
                      valueListenable: _isFilled,
                      builder: (context, isFilled, child) {
                        return SignInButton(
                          onPressed:
                              isFilled ? () => signHandler(context, _iD, _pass) : null,
                          isFilled: isFilled,
                        );
                      },
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
                              builder: (context) => const RegisterUserScreen(),
                            ),
                          );
                        },
                        text: 'Registrarse ahora',
                      ),
                    ),
                  ],
                )
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
