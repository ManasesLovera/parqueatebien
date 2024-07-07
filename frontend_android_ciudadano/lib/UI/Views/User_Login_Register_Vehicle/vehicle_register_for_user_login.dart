import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Data/Api/Add_Vehiculo/add_vechicle_api.dart';
import 'package:frontend_android_ciudadano/Data/Api/Add_User/user_register_api.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/NuevoUser/register_bloc.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/NuevoUser/register_state.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/NuevoRegistro/_00_app_bar.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/NuevoRegistro/_01_custom_textfield_.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/NuevoRegistro/_01_titlle_textfield_.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/NuevoRegistro/_02_custom_buttom_.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/NuevoRegistro/color_dropdownselectitem.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/NuevoRegistro/year_dropdownselectitem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterNewCar extends StatefulWidget {
  const RegisterNewCar({super.key});

  @override
  State<RegisterNewCar> createState() => _RegisterCarState();
}

class _RegisterCarState extends State<RegisterNewCar> {
  final numplacaC = TextEditingController();
  final modeloC = TextEditingController();
  String? selectedYear;
  String? selectedColor;
  final matriculaC = TextEditingController();
  final double progress = 170;
  final List<String> colores = ['Rojo', 'Azul', 'Verde', 'Negro', 'Blanco'];
  final List<String> years =
      List<String>.generate(124, (i) => (DateTime.now().year - i).toString());

  bool _validateFields() {
    if (numplacaC.text.isEmpty ||
        modeloC.text.isEmpty ||
        selectedYear == null ||
        selectedColor == null ||
        matriculaC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Todos los campos son obligatorios')),
      );
      return false;
    }
    if (!RegExp(r'^[A-Z]\d{6}$').hasMatch(numplacaC.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Número de placa debe iniciar con una letra seguida de 6 números')),
      );
      return false;
    }
    if (matriculaC.text.length != 9) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La matrícula debe tener 9 caracteres')),
      );
      return false;
    }
    return true;
  }

  Future<void> _register() async {
    if (_validateFields()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final governmentId = prefs.getString('governmentId');

      if (governmentId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se encontró el ID del usuario')),
        );
        return;
      }

      final success = await AddVehicleApi().addVehicle(
        governmentId: governmentId,
        licensePlate: numplacaC.text,
        registrationDocument: matriculaC.text,
        model: modeloC.text,
        year: selectedYear!,
        color: selectedColor!,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registro exitoso')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al registrar')),
        );
      }
    }
  }

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
                          inputFormatters: [LicensePlateFormatter()],
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Modelo',
                        ),
                        CustomTextField(
                          controller: modeloC,
                          hintText: 'Ingresar modelo',
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Año',
                        ),
                        YearDropdownSelectItem(
                          items: years,
                          selectedItem: selectedYear,
                          onChanged: (value) {
                            setState(() {
                              selectedYear = value;
                            });
                          },
                          hintText: 'Seleccionar año',
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Color',
                        ),
                        ColorDropdown(
                          items: colores,
                          selectedItem: selectedColor,
                          onChanged: (value) {
                            setState(() {
                              selectedColor = value;
                            });
                          },
                          hintText: 'Seleccionar color',
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Matricula',
                        ),
                        CustomTextField(
                          controller: matriculaC,
                          hintText: 'Ingresar numero de matricula',
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(9),
                          ],
                        ),
                        SizedBox(height: 80.h),
                        if (state is RegisterLoading)
                          const CircularProgressIndicator()
                        else
                          SizedBox(
                            child: RegistroButtom(
                              onPressed: () {
                                if (_validateFields()) {
                                  _register();
                                }
                              },
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
