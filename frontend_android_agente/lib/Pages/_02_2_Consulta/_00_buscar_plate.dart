import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/APis/_01.1_consulta_.dart';
import 'package:frontend_android/Bloc/Consulta/bloc_consulta.dart';
import 'package:frontend_android/Bloc/Consulta/state_consulta.dart';
import 'package:frontend_android/Controllers/Consulta/controller_consulta.dart';
import 'package:frontend_android/Handlers/Consulta/dialog_success_error.dart';
import 'package:frontend_android/Pages/_01_Welcome/welcome.dart';
import 'package:frontend_android/Pages/_02_2_Consulta/_01_detalles_vehiculo_consult.dart';
import 'package:frontend_android/Widgets/Consulta/platescreen_widgets.dart';

class EnterPlateNumberScreen extends StatefulWidget {
  const EnterPlateNumberScreen({super.key});

  @override
  EnterPlateNumberScreenState createState() => EnterPlateNumberScreenState();
}

class EnterPlateNumberScreenState extends State<EnterPlateNumberScreen> {
  final EnterPlateNumberController _controller = EnterPlateNumberController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // Fondo blanco
      body: SafeArea(
        child: BlocProvider(
          create: (context) => VehicleBloc(VehicleService()),
          child: BlocListener<VehicleBloc, VehicleState>(
            listener: (context, state) {
              if (state is VehicleLoaded) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => VehicleDetailsScreen(
                      vehicleData: state.vehicleData,
                      lat: state.lat,
                      lon: state.lon,
                    ),
                  ),
                );
              } else if (state is VehicleError) {
                showUniversalSuccessErrorDialog(
                    context, 'Vehículo no encontrado', false);
              }
            },
            child: WillPopScope(
              onWillPop: () async {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Welcome()),
                  (Route<dynamic> route) => false,
                );
                return false;
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h),
                      Center(
                        child: Image.asset(
                          'assets/whiteback/main_w.png',
                          height: 50.h,
                        ),
                      ),
                      SizedBox(height: 65.h),
                      Center(
                        child: Text(
                          'Introduzca el número de placa de su vehículo',
                          style: TextStyle(
                            fontSize: 16.h,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Placa',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 12.h,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      SizedBox(
                        height: 40.h,
                        child: TextFormField(
                          controller: _controller.plateController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.w, horizontal: 20.w),
                            hintText: 'Ingresar Dígitos de la placa',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10.h),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r)),
                              borderSide:
                                  const BorderSide(color: Colors.black12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r)),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                          ),
                          inputFormatters: [
                            UpperCaseTextInputFormatter(),
                            LengthLimitingTextInputFormatter(7),
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^[A-Z0-9]+$')),
                            PlateNumberTextInputFormatter(),
                          ],
                          keyboardType: TextInputType.text,
                          onChanged: (value) => _controller.checkInput(value),
                        ),
                      ),
                      SizedBox(height: 270.h),
                      ValueListenableBuilder<bool>(
                        valueListenable: _controller.isButtonEnabled,
                        builder: (context, isEnabled, child) {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isEnabled && !_controller.isLoading
                                  ? () => _controller.searchVehicle(context)
                                  : null,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14.w),
                                backgroundColor:
                                    isEnabled && !_controller.isLoading
                                        ? const Color(0xFF010F56) // Azul oscuro
                                        : Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: _controller.isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : Text(
                                      'Consultar',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.h,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
