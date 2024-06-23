import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Api/ConsultaDePlacas/_00_api_consulta_placa.dart';
import 'package:frontend_android_ciudadano/Blocs/Vehiculo/_00_vehicle_event.dart';
import 'package:frontend_android_ciudadano/Blocs/Vehiculo/_01_vehicle_state.dart';
import 'package:frontend_android_ciudadano/Blocs/Vehiculo/_02_vehicle_bloc.dart';

void showVehicleDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocProvider(
        create: (context) =>
            VehicleBloc(ConsultaPlaca())..add(FetchLicencePlates()),
        child: Dialog(
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
                      return DropdownButtonFormField<String>(
                        value: state.licencePlates.isNotEmpty
                            ? state.licencePlates[0]
                            : null,
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
                        onChanged: (String? newValue) {},
                      );
                    } else if (state is VehicleError) {
                      return Text('Error: ${state.error}');
                    } else {
                      return Container();
                    }
                  },
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
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
              ],
            ),
          ),
        ),
      );
    },
  );
}
