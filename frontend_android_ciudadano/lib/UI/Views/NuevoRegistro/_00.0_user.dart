import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Data/Api/NuevoRegistro/_00.1_api_nuevo_registro.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/NuevoRegistro/register_bloc.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/NuevoRegistro/register_state.dart';
import 'package:frontend_android_ciudadano/UI/Views/NuevoRegistro/_00.1_car.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/NuevoRegistro/_00_app_bar.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/NuevoRegistro/_01_custom_textfield_.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/NuevoRegistro/_01_titlle_textfield_.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/NuevoRegistro/_02_custom_buttom_.dart';

class RegisterUser extends StatelessWidget {
  RegisterUser({super.key});

  final cedulaC = TextEditingController();
  final nombresC = TextEditingController();
  final apellidosC = TextEditingController();
  final correoC = TextEditingController();
  final passC = TextEditingController();
  final confirmPassC = TextEditingController();

  final double progress = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarRegister(progress: progress),
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
                          controller: cedulaC,
                          hintText: 'Ingresar numero de cedula sin guiones',
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Nombres',
                        ),
                        CustomTextField(
                          controller: nombresC,
                          hintText: 'Ingresar nombres',
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Apellidos',
                        ),
                        CustomTextField(
                          controller: apellidosC,
                          hintText: 'Ingresar apellidos',
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Correo',
                        ),
                        CustomTextField(
                          controller: correoC,
                          hintText: 'Ingresar correo',
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Contraseña',
                        ),
                        CustomTextField(
                          controller: passC,
                          hintText: 'Contraseña',
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Confirmar contraseña',
                        ),
                        CustomTextField(
                          controller: confirmPassC,
                          hintText: 'Confirmar contraseña',
                        ),
                        SizedBox(height: 16.h),
                        if (state is RegisterLoading)
                          const CircularProgressIndicator()
                        else
                          RegistroButtom(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => RegisterCar(),
                                ),
                              );
                            },
                            text: 'Siguiente',
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
