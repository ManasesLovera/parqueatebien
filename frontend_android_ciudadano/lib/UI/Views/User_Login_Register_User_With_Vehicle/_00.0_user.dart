import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Data/Api/Add_User/user_register_api.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/NuevoUser/register_bloc.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/NuevoUser/register_state.dart';
import 'package:frontend_android_ciudadano/UI/Views/User_Login_Register_User_With_Vehicle/_00.1_car.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/NuevoRegistro/_00_app_bar.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/NuevoRegistro/_01_custom_textfield_.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/NuevoRegistro/_01_titlle_textfield_.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/NuevoRegistro/_02_custom_buttom_.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final cedulaC = TextEditingController();
  //
  bool obscureText = true;
  //
  final nombresC = TextEditingController();
  final apellidosC = TextEditingController();
  final correoC = TextEditingController();
  final passC = TextEditingController();
  final confirmPassC = TextEditingController();
  final double progress = 50;
  final RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );

  final ValueNotifier<bool> isButtonEnabled = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    cedulaC.addListener(_updateButtonState);
    nombresC.addListener(_updateButtonState);
    apellidosC.addListener(_updateButtonState);
    correoC.addListener(_updateButtonState);
    passC.addListener(_updateButtonState);
    confirmPassC.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    isButtonEnabled.value = cedulaC.text.isNotEmpty &&
        nombresC.text.isNotEmpty &&
        apellidosC.text.isNotEmpty &&
        correoC.text.isNotEmpty &&
        passC.text.isNotEmpty &&
        confirmPassC.text.isNotEmpty;
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
                          controller: nombresC,
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
                          controller: apellidosC,
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
                          controller: correoC,
                          hintText: 'Ingresar correo',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Contraseña',
                        ),
                        CustomTextField(
                          controller: passC,
                          hintText: 'Contraseña',
                          obscureText: obscureText,
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(
                          text: 'Confirmar contraseña',
                        ),
                        CustomTextField(
                          controller: confirmPassC,
                          hintText: 'Confirmar contraseña',
                          obscureText: obscureText,
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 16.h),
                        if (state is RegisterLoading)
                          const CircularProgressIndicator()
                        else
                          ValueListenableBuilder<bool>(
                            valueListenable: isButtonEnabled,
                            builder: (context, value, child) {
                              return RegistroButtom(
                                onPressed: value
                                    ? () {
                                        if (_validateFields(context)) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => RegisterCar(
                                                governmentId: cedulaC.text,
                                                name: nombresC.text,
                                                lastname: apellidosC.text,
                                                email: correoC.text,
                                                password: passC.text,
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
        )));
  }

  bool _validateFields(BuildContext context) {
    if (cedulaC.text.isEmpty ||
        nombresC.text.isEmpty ||
        apellidosC.text.isEmpty ||
        correoC.text.isEmpty ||
        passC.text.isEmpty ||
        confirmPassC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Todos los campos son obligatorios')),
      );
      return false;
    }
    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(nombresC.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nombres solo debe contener letras')),
      );
      return false;
    }
    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(apellidosC.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Apellidos solo debe contener letras')),
      );
      return false;
    }
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(correoC.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingrese un correo válido')),
      );
      return false;
    }
    if (passC.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('La contraseña debe tener al menos 8 caracteres')),
      );
      return false;
    }

    if (passC.text != confirmPassC.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    cedulaC.dispose();
    nombresC.dispose();
    apellidosC.dispose();
    correoC.dispose();
    passC.dispose();
    confirmPassC.dispose();
    super.dispose();
  }
}

class CedulaFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll('-', ''); // Remove existing dashes
    if (text.length > 11) {
      return oldValue; // Limit to 11 characters
    }

    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 3 || i == 10) {
        buffer.write('-');
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
