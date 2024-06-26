import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Api/NuevoRegistro/_00.1_api_nuevo_registro.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/NuevoRegistro/register_bloc.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/NuevoRegistro/register_state.dart';
import 'package:frontend_android_ciudadano/Data/Models/NuevoRegistro/UserCars/car_model.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/_00_app_bar.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/_01_custom_textfield_.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/_01_titlle_textfield_.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/_02_custom_buttom_.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/_03_dropdownselectitem.dart';

class RegisterCar extends StatelessWidget {
  RegisterCar({super.key});

  final numplacaC = TextEditingController();
  final modeloC = TextEditingController();
  final yearC = TextEditingController();
  final colorC = TextEditingController();
  final matriculaC = TextEditingController();
  final double progress = 170;
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
                          'Datos del vehiculo',
                          style: TextStyle(fontSize: 14.h),
                        ),
                        SizedBox(height: 15.h),
                        const CustomText(
                          text: 'Numero de placa',
                        ),
                        CustomTextField(
                          controller: numplacaC,
                          hintText: 'Ingresar numero',
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Modelo',
                        ),
                        CustomDropdownSelectItem(
                          items: const [],
                          onChanged: (CarModel? value) {},
                          hintText: 'Seleccionar',
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Año',
                        ),
                        CustomDropdownSelectItem(
                          items: const [],
                          onChanged: (CarModel? value) {},
                          hintText: 'Seleccionar',
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Color',
                        ),
                        CustomDropdownSelectItem(
                          items: const [],
                          onChanged: (CarModel? value) {},
                          hintText: 'Seleccionar',
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Matricula',
                        ),
                        CustomTextField(
                          controller: matriculaC,
                          hintText: 'Ingresar numero de matricula',
                        ),
                        SizedBox(height: 80.h),
                        if (state is RegisterLoading)
                          const CircularProgressIndicator()
                        else
                          SizedBox(
                            child: RegistroButtom(
                              onPressed: () {},
                              text: 'Registrarse',
                            ),
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
