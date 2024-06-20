import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Api/NuevoRegistro/_00.1_api_nuevo_registro.dart';
import 'package:frontend_android_ciudadano/Blocs/NuevoRegistro/register_bloc.dart';
import 'package:frontend_android_ciudadano/Blocs/NuevoRegistro/register_event.dart';
import 'package:frontend_android_ciudadano/Blocs/NuevoRegistro/register_state.dart';
import 'package:frontend_android_ciudadano/Models/NuevoRegistro/Users_Model/user_model.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/_00_app_bar.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/_01_custom_textfield_.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/_01_titlle_textfield_.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/_02_custom_buttom_.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final cedulaController = TextEditingController();
  final nombresController = TextEditingController();
  final apellidosController = TextEditingController();
  final correoController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const AppBarRegister(),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.h),
          child: SingleChildScrollView(
            child: BlocProvider(
              create: (_) => RegisterBloc(RegisterApi()),
              child: BlocListener<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registro exitoso')),
                    );
                  } else if (state is RegisterFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                child: BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Divider(
                          height: 2.w,
                          thickness: 3.w,
                          indent: 0.w,
                          endIndent: 0.w,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 25.h),
                        Text(
                          'Datos del usuario',
                          style: TextStyle(fontSize: 14.h),
                        ),
                        SizedBox(height: 15.h),
                        const CustomText(
                          text: 'Cedula',
                        ),
                        CustomTextField(
                          controller: cedulaController,
                          hintText: 'Ingresar numero de cedula sin guiones',
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Nombres',
                        ),
                        CustomTextField(
                          controller: cedulaController,
                          hintText: 'Ingresar nombres',
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Apellidos',
                        ),
                        CustomTextField(
                          controller: cedulaController,
                          hintText: 'Ingresar apellidos',
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Correo',
                        ),
                        CustomTextField(
                          controller: cedulaController,
                          hintText: 'Ingresar correo',
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Contraseña',
                        ),
                        CustomTextField(
                          controller: cedulaController,
                          hintText: 'Contraseña',
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Confirmar contraseña',
                        ),
                        CustomTextField(
                          controller: cedulaController,
                          hintText: 'Confirmar contraseña',
                        ),
                        SizedBox(height: 16.h),
                        if (state is RegisterLoading)
                          const CircularProgressIndicator()
                        else
                          RegistroButtom(
                            onPressed: () {
                              if (passwordController.text ==
                                  confirmPasswordController.text) {
                                final user = User(
                                  cedula: cedulaController.text,
                                  nombres: nombresController.text,
                                  apellidos: apellidosController.text,
                                  correo: correoController.text,
                                  password: passwordController.text,
                                );
                                context
                                    .read<RegisterBloc>()
                                    .add(RegisterSubmitted(user));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Las contraseñas no coinciden')),
                                );
                              }
                            },
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        )));
  }
}
