/*
-- =============================================
-- Author: Erick Daves Garcia Perez
-- Create date: 23/07/2024
-- Description:	APP_CIUDADANO_DEMO-ORIONTEK.
-- =============================================
*/
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Api/ConsultPlates/consult_plates_api.dart';
import 'package:frontend_android_ciudadano/Blocs/VehiculoFetch/_00_vehicle_event.dart';
import 'package:frontend_android_ciudadano/Blocs/VehiculoFetch/_02_vehicle_bloc.dart';
import 'package:frontend_android_ciudadano/Pages/_00_Login/_00_login.dart';

// Definición de colores constantes para la aplicación
const Color lightBlueColor = Color(0xFF009DD4); // Azul Claro
const Color darkBlueColor = Color(0xFF010F56); // Azul Oscuro
const Color greyTextColor = Color(0xFF494A4D); // Gris (Texto)

// Punto de entrada principal de la aplicación
void main() => runApp(const M());

// Clase principal de la aplicación que extiende StatelessWidget
class M extends StatelessWidget {
  const M({super.key});

  @override
  Widget build(BuildContext context) {
    const String governmentId = ''; // Identificación del gobierno (vacía)

    return ScreenUtilInit(
      // Inicializa ScreenUtil con el tamaño de diseño especificado
      designSize: const Size(360, 640),
      builder: (context, child) {
        return MultiBlocProvider(
          // Proporciona múltiples Blocs a la aplicación
          providers: [
            BlocProvider<VehicleBloc>(
              // Proveedor para VehicleBloc
              create: (context) => VehicleBloc(ConsultaPlaca())
                ..add(const FetchLicencePlates(governmentId)),
              // Agrega el evento FetchLicencePlates con governmentId vacío
            )
          ],
          child: const MaterialApp(
            // Widget raíz de la aplicación
            debugShowCheckedModeBanner: false, // Oculta el banner de modo debug
            home: Login(), // Página inicial de la aplicación
          ),
        );
      },
    );
  }
}
