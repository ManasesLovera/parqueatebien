import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_android/Bloc/Consulta/bloc_consulta.dart';
import 'package:frontend_android/Bloc/Consulta/state_consulta.dart';
import 'package:frontend_android/Pages/_02_2_Consulta/_01_detalles_vehiculo_consult.dart';
import 'package:frontend_android/Pages/_01_Welcome/welcome.dart';
import 'package:frontend_android/APis/consulta_.dart';

class EnterPlateNumberScreen extends StatefulWidget {
  const EnterPlateNumberScreen({super.key});

  @override
  EnterPlateNumberScreenState createState() => EnterPlateNumberScreenState();
}

class EnterPlateNumberScreenState extends State<EnterPlateNumberScreen> {
  final TextEditingController plateController = TextEditingController();
  final ValueNotifier<bool> isButtonEnabled = ValueNotifier(false);
  bool isLoading = false;

  void _checkInput(String value) {
    isButtonEnabled.value = value.length == 7;
  }

  Future<void> _searchVehicle() async {
    setState(() {
      isLoading = true;
    });

    try {
      final vehicleData =
          await VehicleService().fetchVehicleDetails(plateController.text);
      final double lat = double.parse(vehicleData['lat'].toString());
      final double lon = double.parse(vehicleData['lon'].toString());

      if (!mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => VehicleDetailsScreen(
            vehicleData: vehicleData,
            lat: lat,
            lon: lon,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    plateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    duration: const Duration(seconds: 3),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {},
                    ),
                  ),
                );
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
                          controller: plateController,
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
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^[A-Z0-9]{1,7}$')),
                            LengthLimitingTextInputFormatter(7),
                          ],
                          keyboardType: TextInputType.text,
                          onChanged: _checkInput,
                        ),
                      ),
                      SizedBox(height: 270.h),
                      ValueListenableBuilder<bool>(
                        valueListenable: isButtonEnabled,
                        builder: (context, isEnabled, child) {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isEnabled && !isLoading
                                  ? _searchVehicle
                                  : null,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14.w),
                                backgroundColor: isEnabled && !isLoading
                                    ? const Color(0xFF010F56) // Azul oscuro
                                    : Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: isLoading
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
