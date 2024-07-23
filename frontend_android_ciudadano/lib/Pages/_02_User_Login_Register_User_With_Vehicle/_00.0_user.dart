import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Api/Add_User/_00_user_register_api.dart';
import 'package:frontend_android_ciudadano/Blocs/NuevoUser/register_bloc.dart';
import 'package:frontend_android_ciudadano/Blocs/NuevoUser/register_state.dart';
import 'package:frontend_android_ciudadano/Controllers/User_Register_Vehicle/user_vehicle_register_controller.dart';
import 'package:frontend_android_ciudadano/Handlers/Login/dialog_success_error_user.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/_00_app_bar.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/_01_custom_textfield_.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/_01_titlle_textfield_.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/_02_custom_buttom_.dart';
import 'package:frontend_android_ciudadano/Pages/_02_User_Login_Register_User_With_Vehicle/_00.1_car.dart';

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({super.key});

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final controller = RegisterUserController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // Fondo blanco
      appBar: AppBarRegister(progress: controller.progress),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.h),
          child: SingleChildScrollView(
            child: BlocProvider(
              create: (_) => RegisterBloc(RegisterApi()),
              child: BlocListener<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterSuccess) {
                    showUniversalSuccessErrorDialog(
                        context, 'Registro exitoso', true);
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => RegisterCar(
                            governmentId: controller.cedulaC.text,
                            name: controller.nombresC.text,
                            lastname: controller.apellidosC.text,
                            email: controller.correoC.text,
                            password: controller.passC.text,
                          ),
                        ),
                      );
                    });
                  } else if (state is RegisterFailure) {
                    showUniversalSuccessErrorDialog(
                        context, state.error, false);
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
                          controller: controller.cedulaC,
                          hintText: 'Ingresar numero de cedula sin guiones',
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CedulaFormatter(),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Nombres',
                        ),
                        CustomTextField(
                          controller: controller.nombresC,
                          hintText: 'Ingresar nombres',
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z\s]')),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Apellidos',
                        ),
                        CustomTextField(
                          controller: controller.apellidosC,
                          hintText: 'Ingresar apellidos',
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z\s]')),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Correo',
                        ),
                        CustomTextField(
                          controller: controller.correoC,
                          hintText: 'Ingresar correo',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Contraseña',
                        ),
                        CustomTextField(
                          controller: controller.passC,
                          hintText: 'Contraseña',
                          obscureText: controller.obscureText,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                controller.obscureText =
                                    !controller.obscureText;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Confirmar contraseña',
                        ),
                        CustomTextField(
                          controller: controller.confirmPassC,
                          hintText: 'Confirmar contraseña',
                          obscureText: controller.obscureText,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                controller.obscureText =
                                    !controller.obscureText;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 16.h),
                        if (state is RegisterLoading)
                          const CircularProgressIndicator()
                        else
                          ValueListenableBuilder<bool>(
                            valueListenable: controller.isButtonEnabled,
                            builder: (context, value, child) {
                              return RegistroButtom(
                                onPressed: value
                                    ? () {
                                        if (controller
                                            .validateFields(context)) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => RegisterCar(
                                                governmentId:
                                                    controller.cedulaC.text,
                                                name: controller.nombresC.text,
                                                lastname:
                                                    controller.apellidosC.text,
                                                email: controller.correoC.text,
                                                password: controller.passC.text,
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    : null,
                                text: 'Siguiente',
                                isEnabled: value,
                              );
                            },
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
