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
  final _iD = TextEditingController(); // Controlador para el campo de cédula
  final _pass =
      TextEditingController(); // Controlador para el campo de contraseña
  bool obscureText =
      true; // Estado para controlar la visibilidad de la contraseña
  final ValueNotifier<bool> _isFilled = ValueNotifier(
      false); // Notificador para el estado del botón de inicio de sesión

  @override
  void initState() {
    super.initState();
    _iD.addListener(
        _updateButtonState); // Agrega un listener para actualizar el estado del botón cuando cambie el texto del campo de cédula
    _pass.addListener(
        _updateButtonState); // Agrega un listener para actualizar el estado del botón cuando cambie el texto del campo de contraseña
  }

  // Actualiza el estado del botón según los campos de entrada
  void _updateButtonState() {
    _isFilled.value = _iD.text.isNotEmpty && _pass.text.isNotEmpty;
  }

  // Limpia los campos de entrada
  void clearFields() {
    _iD.clear();
    _pass.clear();
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
      backgroundColor:
          const Color.fromARGB(255, 9, 157, 210), // Color de fondo azul claro
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50.h),
                const CustomImageLogoLogin(
                    img: 'assets/splash/main.png',
                    altura: 100), // Logo de la aplicación
                SizedBox(height: 50.h),
                const Usertext(
                  text: 'Cedula',
                ),
                Column(
                  children: [
                    CustomTextField(
                      controller: _iD,
                      hintText:
                          'Ingresar cedula', // Campo para ingresar la cédula
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CedulaFormatterCedula(), // Formato de entrada para la cédula
                      ],
                    ),
                    SizedBox(height: 20.h),
                    const Usertext(
                      text: 'Contraseña',
                    ),
                    CustomTextField(
                      controller: _pass,
                      hintText:
                          'Ingresar la contraseña', // Campo para ingresar la contraseña
                      obscureText: obscureText,
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureText
                              ? Icons.visibility
                              : Icons
                                  .visibility_off, // Icono para mostrar/ocultar la contraseña
                        ),
                        onPressed: () {
                          setState(() {
                            obscureText =
                                !obscureText; // Alterna la visibilidad de la contraseña
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ValueListenableBuilder<bool>(
                      valueListenable: _isFilled,
                      builder: (context, isFilled, child) {
                        return SignInButton(
                          onPressed: isFilled
                              ? () => signHandler(context, _iD,
                                  _pass) // Maneja el inicio de sesión si los campos están llenos
                              : null,
                          isFilled: isFilled,
                        );
                      },
                    ),
                    SizedBox(height: 15.h),
                    const ForgotPasswordText(
                      text:
                          '¿Olvidaste tu Contraseña?', // Texto para la opción de recuperar la contraseña
                    ),
                    SizedBox(height: 80.h),
                    const DontAccount(
                      text:
                          '¿No tienes una cuenta?', // Texto para la opción de registro
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      child: RegisterNow(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterUserScreen(), // Navega a la pantalla de registro
                            ),
                          );
                        },
                        text: 'Registrarse ahora', // Botón para registrarse
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

// Formateador de texto para la cédula
class CedulaFormatterCedula extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text =
        newValue.text.replaceAll('-', ''); // Elimina guiones existentes
    if (text.length > 11) {
      return oldValue; // Limita a 11 caracteres
    }

    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 3 || i == 10) {
        buffer.write('-'); // Añade guiones en las posiciones adecuadas
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
