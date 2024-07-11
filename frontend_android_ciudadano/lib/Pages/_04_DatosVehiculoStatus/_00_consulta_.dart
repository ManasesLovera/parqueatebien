import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Api/ConsultPlates/consult_plates_api.dart';
import 'package:frontend_android_ciudadano/Blocs/VehiculoFetch/_00_vehicle_event.dart';
import 'package:frontend_android_ciudadano/Blocs/VehiculoFetch/_01_vehicle_state.dart';
import 'package:frontend_android_ciudadano/Blocs/VehiculoFetch/_02_vehicle_bloc.dart';
import 'package:frontend_android_ciudadano/Pages/_04_DatosVehiculoStatus/_01_vehiculo_data.dart';
import 'package:frontend_android_ciudadano/Pages/_01_Welcome/_00_welcome.dart';


Future<bool?> showVehicleDialog(BuildContext context, String governmentId) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      String? selectedPlate;
      return BlocProvider(
        create: (context) =>
            VehicleBloc(ConsultaPlaca())..add(FetchLicencePlates(governmentId)),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.r),
                      child: Text(
                        'Seleccione el número de placa a consultar',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.5.h,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Placa',
                        style: TextStyle(color: Colors.blue, fontSize: 12.h),
                      ),
                    ),
                    BlocBuilder<VehicleBloc, VehicleState>(
                      builder: (context, state) {
                        if (state is VehicleLoading) {
                          return const CircularProgressIndicator();
                        } else if (state is VehicleLoaded) {
                          if (selectedPlate == null &&
                              state.licencePlates.isNotEmpty) {
                            selectedPlate = state.licencePlates[0];
                          }
                          return DropdownButtonFormField<String>(
                            value: selectedPlate,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            items: state.licencePlates.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedPlate = newValue;
                              });
                              BlocProvider.of<VehicleBloc>(context)
                                  .add(SelectLicencePlate(newValue!));
                            },
                          );
                        } else if (state is VehicleError) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _showUniversalSuccessErrorDialog(
                              context,
                              state.error,
                              icon: Icons.warning,
                              iconColor: Colors.red,
                            );
                          });
                          return Container(); // return an empty container to avoid UI error
                        } else {
                          return Container();
                        }
                      },
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (selectedPlate != null) {
                            BlocProvider.of<VehicleBloc>(context)
                                .add(FetchVehicleDetails(selectedPlate!));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: const Text('Consultar'),
                      ),
                    ),
                    BlocListener<VehicleBloc, VehicleState>(
                      listener: (context, state) {
                        if (state is VehicleDetailsLoaded) {
                          Navigator.of(context).pop(true);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: BlocProvider.of<VehicleBloc>(context),
                                child: CarDetails(licensePlate: selectedPlate!),
                              ),
                            ),
                          );
                        } else if (state is VehicleError) {
                          _showUniversalSuccessErrorDialog(
                            context,
                            state.error,
                            icon: Icons.warning,
                            iconColor: Colors.red,
                          );
                        } else if (state is VehicleNotFound) {
                          Navigator.of(context).pop();
                          _showUniversalSuccessErrorDialog(
                            context,
                            'Vehículo no reportado',
                            icon: Icons.info,
                            iconColor: Colors.blue,
                          );
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const Welcome(),
                              ),
                            );
                          });
                        }
                      },
                      child: Container(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

void _showUniversalSuccessErrorDialog(BuildContext context, String message,
    {required IconData icon, required Color iconColor}) {
  showDialog(
    context: context,
    barrierDismissible: false, // No permitir cerrar el diálogo tocando fuera
    builder: (BuildContext context) {
      // Cerrar el diálogo automáticamente después de 2 segundos
      Future.delayed(const Duration(seconds: 2), () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      });

      return PopScope(
        onPopInvoked: (shouldPop) => false, // Deshabilitar botón de retroceso
        child: AlertDialog(
          title: const SizedBox.shrink(), // No mostrar título
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon, // Ícono pasado como parámetro
                color: iconColor, // Color pasado como parámetro
                size: 48.h,
              ),
              SizedBox(height: 16.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.h,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
