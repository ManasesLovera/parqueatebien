import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Blocs/Login/LoginLogic/_02_login_bloc.dart';
import 'package:frontend_android_ciudadano/Views/Welcome/_00_welcome.dart';

void main() => runApp(const M());

class M extends StatelessWidget {
  const M({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(),
            ),
            // BlocProvider<StatusBarCubit>(
            //   create: (context) => StatusBarCubit(),
            // ),
          ],
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Welcome(),
          ),
        );
      },
    );
  }
}
