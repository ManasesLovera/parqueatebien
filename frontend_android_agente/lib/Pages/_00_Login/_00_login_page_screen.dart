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
    final iD = TextEditingController(); // Controlador de texto para el usuario.
    final pass =
        TextEditingController(); // Controlador de texto para la contraseña.
    const String role =
        ''; // Rol de usuario, se puede definir según sea necesario.

    return BlocProvider(
        create: (context) =>
            ClassLoginCubit(), // Proveedor del Cubit para el estado del botón de login.
        child: Scaffold(
          backgroundColor: const Color(
              0xFF010F56), // Color de fondo de la pantalla de login.
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 0.h), // Alineación horizontal.
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 50.h), // Espacio vertical.
                    const LoginWidgets(), // Widgets generales de login.
                    SizedBox(height: 50.h), // Espacio vertical.
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
                      obscureText: true, // Ocultar texto para contraseñas.
                      suffixIcon: const Icon(Icons
                          .remove_red_eye), // Icono para mostrar/ocultar contraseña.
                      inputFormatters: const [], // Formateadores de entrada (vacío en este caso).
                    ),
                    BlocBuilder<ClassLoginCubit, bool>(
                      builder: (context, isFilled) {
                        return ClasLoginButton(
                            onPressed: isFilled
                                ? () => methodHandlerLoginFuture(
                                    context,
                                    iD,
                                    pass,
                                    role) // Método de login si los campos están llenos.
                                : null,
                            isFilled:
                                isFilled); // Estado del botón según los campos llenos.
                      },
                    ),
                    SizedBox(height: 20.h), // Espacio vertical.
                    const ForgotPasswordText(), // Texto de "Olvidé mi contraseña".
                    SizedBox(height: 140.h), // Espacio vertical.
                    const BottomImage() // Imagen en la parte inferior.
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
