import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Api/AddNew_Vehicle/add_new_vehicle.dart';
import 'package:frontend_android_ciudadano/Blocs/Vehicle_New_Add/new_vehicle_registration_bloc.dart';
import 'package:frontend_android_ciudadano/Blocs/Vehicle_New_Add/new_vehicle_registration_state.dart';
import 'package:frontend_android_ciudadano/Controllers/Vehicle_User_Register/register_car_controller.dart';
import 'package:frontend_android_ciudadano/Handlers/User_vehicle_Register/dialog_success_error_car_new.dart';
import 'package:frontend_android_ciudadano/Pages/_01_Welcome/_00_welcome.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/color_dropdownselectitem.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/user_register_widgets.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/year_picker_select_item.dart';

class RegisterNewCarScreen extends StatefulWidget {
  const RegisterNewCarScreen({super.key});

  @override
  State<RegisterNewCarScreen> createState() => _RegisterNewCarState();
}

class _RegisterNewCarState extends State<RegisterNewCarScreen> {
  final controller = NewRegisterCarController();

  @override
  void initState() {
    super.initState();
    controller.numplacaC.addListener(controller.updateButtonStateNew);
    controller.matriculaC.addListener(controller.updateButtonStateNew);
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
              create: (_) => NewVehicleRegistrationBloc(AddNewVehicleApi()),
              child: BlocListener<NewVehicleRegistrationBloc,
                  NewVehicleRegistrationState>(
                listener: (context, state) {
                  if (state is NewVehicleRegistrationSuccess) {
                    showUniversalSuccessErrorDialogCarNewNew(
                      context,
                      'Vehiculo registrado, espere confirmacion para consulta',
                      true,
                    );
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const Welcome(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    });
                  } else if (state is NewVehicleRegistrationFailure) {
                    showUniversalSuccessErrorDialogCarNewNew(
                      context,
                      state.error,
                      false,
                    );
                  }
                },
                child: BlocBuilder<NewVehicleRegistrationBloc,
                    NewVehicleRegistrationState>(
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
                          text: 'Marca',
                        ),
                        CustomTextField(
                          controller: controller.modelController,
                          hintText: 'Ingresar Marca',
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Año',
                        ),
                        YearPickerSelectItem(
                          initialYear: controller.selectedYear != null
                              ? int.parse(controller.selectedYear!)
                              : DateTime.now().year,
                          onChanged: (value) {
                            setState(() {
                              controller.selectedYear = value?.toString();
                              controller.updateButtonStateNew();
                            });
                          },
                          dropdownBackgroundColor: const Color(0xFFFFFFFF),
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
                            });
                            controller.updateButtonStateNew();
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
                        if (state is NewVehicleRegistrationLoading)
                          const CircularProgressIndicator()
                        else
                          ValueListenableBuilder<bool>(
                            valueListenable: controller.isButtonEnabled,
                            builder: (context, isEnabled, child) {
                              return RegistroButtom(
                                onPressed: isEnabled
                                    ? () => controller.registerNew(context)
                                    : null,
                                text: 'Registrar',
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
