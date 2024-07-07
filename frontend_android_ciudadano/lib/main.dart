import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Data/Api/ConsultPlates/consult_plates_api.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/Login/Login_Bloc/_02_login_bloc.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/VehiculoFetch/_00_vehicle_event.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/VehiculoFetch/_02_vehicle_bloc.dart';
import 'package:frontend_android_ciudadano/UI/Views/Login/_00_login.dart';

void main() => runApp(const M());

class M extends StatelessWidget {
  const M({super.key});
  @override
  Widget build(BuildContext context) {
    const String governmentId = '';

    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(),
            ),
            BlocProvider<VehicleBloc>(
              create: (context) => VehicleBloc(ConsultaPlaca())
                ..add(const FetchLicencePlates(governmentId)),
            )
          ],
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Login(),
          ),
        );
      },
    );
  }
}
