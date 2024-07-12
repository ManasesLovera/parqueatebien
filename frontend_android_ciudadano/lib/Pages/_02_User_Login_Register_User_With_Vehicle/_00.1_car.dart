import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Api/Add_User/user_register_api.dart';
import 'package:frontend_android_ciudadano/Blocs/NuevoUser/register_bloc.dart';
import 'package:frontend_android_ciudadano/Blocs/NuevoUser/register_state.dart';
import 'package:frontend_android_ciudadano/Controllers/User_Register_Vehicle/register_car_controller.dart';
import 'package:frontend_android_ciudadano/Handlers/User_vehicle_Register/dialog_success_error_cart.dart';
import 'package:frontend_android_ciudadano/Pages/_00_Login/_00_login.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/_00_app_bar.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/_01_custom_textfield_.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/_01_titlle_textfield_.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/_02_custom_buttom_.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/color_dropdownselectitem.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/year_dropdownselectitem.dart';

class RegisterCar extends StatefulWidget {
  final String governmentId;
  final String name;
  final String lastname;
  final String email;
  final String password;

  const RegisterCar({
    super.key,
    required this.governmentId,
    required this.name,
    required this.lastname,
    required this.email,
    required this.password,
  });

  @override
  State<RegisterCar> createState() => _RegisterCarState();
}

class _RegisterCarState extends State<RegisterCar> {
  final controller = RegisterCarController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // Fondo blanco
      appBar: const AppBarRegister(progress: 170),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.h),
          child: SingleChildScrollView(
            child: BlocProvider(
              create: (_) => RegisterBloc(RegisterApi()),
              child: BlocListener<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterSuccess) {
                    showUniversalSuccessErrorDialogCar(
                        context, 'Registro exitoso', true);
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) =>
                              const Login(), // Reemplazar con tu pantalla de login
                        ),
                        (Route<dynamic> route) => false,
                      );
                    });
                  } else if (state is RegisterFailure) {
                    showUniversalSuccessErrorDialogCar(
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
                          'Datos del vehiculo',
                          style: TextStyle(fontSize: 14.h),
                        ),
                        SizedBox(height: 15.h),
                        const CustomText(
                          text: 'Numero de placa',
                        ),
                        CustomTextField(
                          controller: controller.numplacaC,
                          hintText: 'Ingresar numero',
                          inputFormatters: [LicensePlateFormatter()],
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Modelo',
                        ),
                        CustomTextField(
                            controller: controller.modelController,
                            hintText: 'Ingresar modelo'),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Año',
                        ),
                        YearDropdownSelectItem(
                          items: controller.years,
                          selectedItem: controller.selectedYear,
                          onChanged: (value) {
                            setState(() {
                              controller.selectedYear = value;
                              controller.updateButtonState();
                            });
                          },
                          hintText: 'Seleccionar año', dropdownBackgroundColor: const Color(0xFFFFFFFF),
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Color',
                        ),
                        ColorDropdown(
                          items: controller.colors,
                          selectedItem: controller.selectedColor,
                          onChanged: (value) {
                            setState(() {
                              controller.selectedColor = value;
                              controller.updateButtonState();
                            });
                          },
                          hintText: 'Seleccionar color',
                          dropdownBackgroundColor: const Color(0xFFFFFFFF),
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Matricula',
                        ),
                        CustomTextField(
                          controller: controller.matriculaC,
                          hintText: 'Ingresar numero de matricula',
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(9),
                          ],
                        ),
                        SizedBox(height: 80.h),
                        if (state is RegisterLoading)
                          const CircularProgressIndicator()
                        else
                          ValueListenableBuilder<bool>(
                            valueListenable: controller.isButtonEnabled,
                            builder: (context, isEnabled, child) {
                              return RegistroButtom(
                                onPressed: isEnabled
                                    ? () => controller.register(context, widget)
                                    : () {
                                        showUniversalSuccessErrorDialogCar(
                                            context,
                                            'Todos los campos son obligatorios',
                                            false);
                                      },
                                text: 'Registrarse',
                                isEnabled: isEnabled,
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

class LicensePlateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.toUpperCase();

    if (text.isEmpty) {
      return newValue;
    }
    if (text.length == 1) {
      if (RegExp(r'^[A-Z]$').hasMatch(text)) {
        return newValue.copyWith(
          text: text,
          selection: newValue.selection,
        );
      }
    } else if (text.length <= 7) {
      if (RegExp(r'^[A-Z]\d{0,6}$').hasMatch(text)) {
        return newValue.copyWith(
          text: text,
          selection: newValue.selection,
        );
      }
    }
    return oldValue;
  }
}
