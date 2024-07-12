import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Api/Add_Vehiculo/add_vechicle_api.dart';
import 'package:frontend_android_ciudadano/Blocs/VehiculoRegister/_00_registration_event.dart';
import 'package:frontend_android_ciudadano/Blocs/VehiculoRegister/_01_registration_state.dart';
import 'package:frontend_android_ciudadano/Blocs/VehiculoRegister/_02_registration_bloc.dart';
import 'package:frontend_android_ciudadano/Pages/_01_Welcome/_00_welcome.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/_00_app_bar.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/_01_custom_textfield_.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/_01_titlle_textfield_.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/_02_custom_buttom_.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/color_dropdownselectitem.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/year_dropdownselectitem.dart';

const Color lightBlueColor = Color(0xFF009DD4); // Azul Claro
const Color darkBlueColor = Color(0xFF010F56); // Azul Oscuro
const Color greyTextColor = Color(0xFF494A4D); // Gris (Texto)

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
  final ValueNotifier<bool> isButtonEnabled = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    numplacaC.addListener(_updateButtonState);
    modeloC.addListener(_updateButtonState);
    matriculaC.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    isButtonEnabled.value = numplacaC.text.isNotEmpty &&
        modeloC.text.isNotEmpty &&
        selectedYear != null &&
        selectedColor != null &&
        matriculaC.text.isNotEmpty;
  }

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

  void _register(BuildContext context) {
    if (_validateFields()) {
      context.read<VehicleRegistrationBloc>().add(FetchGovernmentId(
            licensePlate: numplacaC.text,
            vehicleType: 'Car',
            vehicleColor: selectedColor!,
            model: modeloC.text,
            year: selectedYear!,
            matricula: matriculaC.text,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // Fondo blanco
      appBar: AppBarRegister(progress: progress),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.h),
          child: SingleChildScrollView(
            child: BlocProvider(
              create: (_) => VehicleRegistrationBloc(AddVehicleApi()),
              child: BlocListener<VehicleRegistrationBloc,
                  VehicleRegistrationState>(
                listener: (context, state) {
                  if (state is VehicleRegistrationSuccess) {
                    _showUniversalSuccessErrorDialog(
                      context,
                      'Registro exitoso',
                      Icons.check_circle,
                      Colors.green,
                    );
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const Welcome(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    });
                  } else if (state is VehicleRegistrationFailure) {
                    _showUniversalSuccessErrorDialog(
                      context,
                      state.error,
                      Icons.warning,
                      Colors.orange,
                    );
                  }
                },
                child: BlocBuilder<VehicleRegistrationBloc,
                    VehicleRegistrationState>(
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
                            _updateButtonState();
                          },
                          hintText: 'Seleccionar año',
                          dropdownBackgroundColor: const Color(0xFFFFFFFF),
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
                            _updateButtonState();
                          },
                          hintText: 'Seleccionar color',
                          dropdownBackgroundColor: const Color(0xFFFFFFFF),
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
                        if (state is VehicleRegistrationLoading)
                          const CircularProgressIndicator()
                        else
                          ValueListenableBuilder<bool>(
                            valueListenable: isButtonEnabled,
                            builder: (context, isEnabled, child) {
                              return RegistroButtom(
                                onPressed:
                                    isEnabled ? () => _register(context) : null,
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

void _showUniversalSuccessErrorDialog(
    BuildContext context, String message, IconData icon, Color iconColor) {
  showDialog(
    context: context,
    barrierDismissible: false, // No permitir cerrar el diálogo tocando fuera
    builder: (BuildContext context) {
      // Cerrar el diálogo automáticamente después de 2 segundos
      Future.delayed(const Duration(seconds: 2), () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      });

      return PopScope(
        onPopInvoked: (shouldPop) => false, // Deshabilitar botón de retroceso
        child: AlertDialog(
          title: const SizedBox.shrink(), // No mostrar título
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon, // Ícono dinámico
                color: iconColor, // Color dinámico
                size: 48.0,
              ),
              SizedBox(height: 16.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.h,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
