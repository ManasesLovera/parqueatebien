import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Blocs/_02_login_bloc.dart';
import 'package:frontend_android_ciudadano/Views/Login/_00_login.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 640),
        builder: (context, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: BlocProvider(
                create: (context) => LoginBloc(),
                child: const Login(),
              ));
        });
  }
}
