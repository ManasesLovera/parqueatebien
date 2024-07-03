import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/Login/ButtomLoginState/button_state_bloc.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/Login/LoginLogic/_00_login_event.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/Login/LoginLogic/_01_login_state.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/Login/LoginLogic/_02_login_bloc.dart';
import 'package:frontend_android_ciudadano/UI/Views/Welcome/_00_welcome.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/NuevoRegistro/_02_custom_buttom_.dart';

class SignInBlocBuilder extends StatelessWidget {
  final TextEditingController iD;
  final TextEditingController pass;
  final String role;

  const SignInBlocBuilder({
    required this.iD,
    required this.pass,
    super.key,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginSuccess) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Welcome(),
          ),
        );
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Column(
          children: [
            if (state is LoginLoading)
              const CircularProgressIndicator()
            else
              BlocBuilder<ButtonStateBloc, ButtonState>(
                builder: (context, buttonState) {
                  return RegistroButtom(
                    onPressed: buttonState.isEnabled
                        ? () {
                            context.read<LoginBloc>().add(
                                  LoginSubmitted(iD.text, pass.text, role),
                                );
                          }
                        : null,
                    isEnabled: buttonState.isEnabled,
                    text: 'Ingresar',
                  );
                },
              ),
            SizedBox(height: 4.h),
            if (state is LoginFailure)
              Column(
                children: [
                  Text(
                    state.error,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FutureBuilder(
                    future: Future.delayed(const Duration(seconds: 5)),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        context.read<LoginBloc>().add(ClearError());
                      }
                      return Container();
                    },
                  ),
                ],
              ),
          ],
        );
      },
    ));
  }
}
