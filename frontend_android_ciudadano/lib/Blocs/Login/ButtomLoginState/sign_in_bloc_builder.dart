import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Blocs/Login/ButtomLoginState/button_state_bloc.dart';
import 'package:frontend_android_ciudadano/Blocs/Login/LoginLogic/_00_login_event.dart';
import 'package:frontend_android_ciudadano/Blocs/Login/LoginLogic/_01_login_state.dart';
import 'package:frontend_android_ciudadano/Blocs/Login/LoginLogic/_02_login_bloc.dart';

import 'package:frontend_android_ciudadano/Widgets/Login/_08_sign_in_button.dart';

class SignInBlocBuilder extends StatelessWidget {
  final TextEditingController iD;
  final TextEditingController pass;

  const SignInBlocBuilder({
    required this.iD,
    required this.pass,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Column(
          children: [
            if (state is LoginLoading)
              const CircularProgressIndicator()
            else
              BlocBuilder<ButtonStateBloc, ButtonState>(
                builder: (context, buttonState) {
                  return SignInButton(
                    onPressed: buttonState.isEnabled
                        ? () {
                            context.read<LoginBloc>().add(
                                  LoginSubmitted(
                                    iD.text,
                                    pass.text,
                                  ),
                                );
                          }
                        : null,
                    isEnabled: buttonState.isEnabled,
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
    );
  }
}
