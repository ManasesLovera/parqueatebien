import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Blocs/_00_login_event.dart';
import 'package:frontend_android_ciudadano/Blocs/_01_login_state.dart';
import 'package:frontend_android_ciudadano/Blocs/_02_login_bloc.dart';
import 'package:frontend_android_ciudadano/Widgets/Login/_05_sign_in_button%20copy.dart';

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
        if (state is LoginLoading) {
          return const CircularProgressIndicator();
        } else if (state is LoginFailure) {
          return Column(
            children: [
              SignInButton(
                onPressed: () {
                  context.read<LoginBloc>().add(
                        LoginSubmitted(
                          iD.text,
                          pass.text,
                        ),
                      );
                },
              ),
              SizedBox(height: 4.h),
              Text(
                state.error,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.h,
                    fontWeight: FontWeight.bold),
              ),
            ],
          );
        } else {
          return SignInButton(
            onPressed: () {
              context.read<LoginBloc>().add(
                    LoginSubmitted(
                      iD.text,
                      pass.text,
                    ),
                  );
            },
          );
        }
      },
    );
  }
}
