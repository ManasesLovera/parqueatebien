import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Api/ConsultPlates/consult_plates_api.dart';
import 'package:frontend_android_ciudadano/Blocs/VehiculoFetch/_00_vehicle_event.dart';
import 'package:frontend_android_ciudadano/Blocs/VehiculoFetch/_01_vehicle_state.dart';
import 'package:frontend_android_ciudadano/Blocs/VehiculoFetch/_02_vehicle_bloc.dart';
import 'package:frontend_android_ciudadano/Pages/_00_Login/_00_login.dart';
import 'package:frontend_android_ciudadano/Pages/_03_Register_Vehicle/vehicle_register_for_user_login.dart';
import 'package:frontend_android_ciudadano/Pages/_04_DatosVehiculoStatus/_00_consulta_.dart';
import 'package:frontend_android_ciudadano/Widgets/GlobalsWidgets/_00_logo_image.dart';
import 'package:frontend_android_ciudadano/Widgets/Welcome/_01_welcometext.dart';
import 'package:frontend_android_ciudadano/Widgets/Welcome/_02_subtituloreport.dart';
import 'package:frontend_android_ciudadano/Widgets/Welcome/_04_report_buttom.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  WelcomeState createState() => WelcomeState();
}

class WelcomeState extends State<Welcome> {
  late Future<String?> _governmentIdFuture;

  @override
  void initState() {
    super.initState();
    _governmentIdFuture = _getGovernmentId();
  }

  Future<String?> _getGovernmentId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('governmentId');
  }

  void _logout(BuildContext context) async {
    // Modificado
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) {
        return Login(
          key: GlobalKey(), // Asegurarse de que se cree una nueva instancia
        );
      }),
    );
  }

  Future<bool> _showLogoutConfirmation(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.warning,
                  color: Colors.orange,
                  size: 80,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Confirmación',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '¿Estás seguro que quieres cerrar sesión?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pop(false); // Close the dialog and return false
                      },
                    ),
                    TextButton(
                      child: const Text(
                        'Salir',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pop(true); // Close the dialog and return true
                        _logout(context); // Log out and navigate to login
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    return result == true;
  }

  Future<bool> _onWillPop() async {
    return await _showLogoutConfirmation(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.h),
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  const CustomImageLogo(
                      img: 'assets/whiteback/main_w.png', altura: 60),
                  SizedBox(height: 35.h),
                  const WelcomeText(),
                  SizedBox(height: 5.h),
                  const SubtituloReport(sub: '¿Qué deseas realizar hoy?'),
                  SizedBox(height: 18.h),
                  FutureBuilder<String?>(
                    future: _governmentIdFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError || !snapshot.hasData) {
                        return const Text('Error al obtener el ID del usuario');
                      } else {
                        final governmentId = snapshot.data!;
                        return BlocProvider(
                          create: (context) => VehicleBloc(ConsultaPlaca()),
                          child: BlocBuilder<VehicleBloc, VehicleState>(
                            builder: (context, state) {
                              return Column(
                                children: [
                                  ReportConsultButtom(
                                    svgPath: 'assets/icons/car.svg',
                                    title: 'Consulta de vehículo',
                                    subtitle:
                                        'Consulta si tu vehículo ha sido incautado',
                                    onTap: () async {
                                      if (mounted) {
                                        final result = await showVehicleDialog(
                                            context, governmentId);
                                        if (result == true && mounted) {
                                          BlocProvider.of<VehicleBloc>(context)
                                              .add(FetchLicencePlates(
                                                  governmentId));
                                        }
                                      }
                                    },
                                  ),
                                  ReportConsultButtom(
                                    svgPath: 'assets/icons/create.svg',
                                    title: 'Agregar otro vehículo',
                                    subtitle:
                                        'Si posees otro vehículo, añade los datos para futuras consultas',
                                    onTap: () {
                                      if (mounted) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterNewCarScreen(),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  ReportConsultButtom(
                                    svgPath: 'assets/icons/chat.svg',
                                    title: 'Chat de soporte',
                                    subtitle:
                                        'Obtén asistencia inmediata a través de nuestro chat de soporte',
                                    onTap: () {},
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
