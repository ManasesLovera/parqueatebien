import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Api/ConsultPlates/consult_plates_api.dart';
import 'package:frontend_android_ciudadano/Blocs/VehiculoFetch/_00_vehicle_event.dart';
import 'package:frontend_android_ciudadano/Blocs/VehiculoFetch/_01_vehicle_state.dart';
import 'package:frontend_android_ciudadano/Blocs/VehiculoFetch/_02_vehicle_bloc.dart';
import 'package:frontend_android_ciudadano/Pages/_04_DatosVehiculoStatus/_02_detalles_info.dart';
import 'package:frontend_android_ciudadano/Widgets/GlobalsWidgets/_00_logo_image.dart';
import 'package:frontend_android_ciudadano/Widgets/Vehiculo/down_field.dart';
import 'package:frontend_android_ciudadano/Widgets/Vehiculo/map_vehiculo.dart';
import 'package:frontend_android_ciudadano/Widgets/Vehiculo/photos_vehiculo.dart';
import 'package:frontend_android_ciudadano/Widgets/Vehiculo/status_button_label.dart';
import 'package:frontend_android_ciudadano/Widgets/Vehiculo/subtext.dart';
import 'package:frontend_android_ciudadano/Widgets/Vehiculo/upfieldtext.dart';

import 'package:geocoding/geocoding.dart';

class CarDetails extends StatelessWidget {
  final String licensePlate;

  const CarDetails({super.key, required this.licensePlate});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          VehicleBloc(ConsultaPlaca())..add(FetchVehicleDetails(licensePlate)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.h),
              child: BlocBuilder<VehicleBloc, VehicleState>(
                builder: (context, state) {
                  if (state is VehicleDetailsLoaded) {
                    final details = state.vehicleDetails;
                    final List<dynamic> photos = details['photos'];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15.h),
                        Stack(
                          children: [
                            const Align(
                              alignment: Alignment.center,
                              child: CustomImageLogo(
                                img: 'assets/whiteback/main_w.png',
                                altura: 50,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                icon: const Icon(Icons.info),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ReportInfoScreen(
                                          vehicleData: details),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40.h),
                        const Center(
                          child: VehiculoSubText(sub: 'Datos del vehiculo'),
                        ),
                        SizedBox(height: 5.h),
                        Center(
                          child: SizedBox(
                            height: 22.h,
                            child: SatusButtom(details: details),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        const Upfields(text: 'Numero de placa'),
                        Downfield(
                          details: details,
                          detailKey: 'licensePlate',
                        ),
                        const Divider(),
                        const Upfields(text: 'Tipo de vehículo'),
                        SizedBox(height: 1.h),
                        Downfield(
                          details: details,
                          detailKey: 'vehicleType',
                        ),
                        const Divider(),
                        const Upfields(text: 'Color'),
                        SizedBox(height: 1.h),
                        Downfield(
                          details: details,
                          detailKey: 'vehicleColor',
                        ),
                        const Divider(),
                        const Upfields(text: 'Ubicacion de la retencion'),
                        FutureBuilder<String>(
                          future: _getAddressFromLatLng(
                            double.parse(details['lat']),
                            double.parse(details['lon']),
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text(
                                'Cargando dirección...',
                                style: TextStyle(fontSize: 10.h),
                              );
                            } else if (snapshot.hasError) {
                              return Text(
                                'Error al obtener la dirección',
                                style: TextStyle(fontSize: 10.h),
                              );
                            } else {
                              return Text(
                                snapshot.data ?? 'Dirección no encontrada',
                                style: TextStyle(
                                    fontSize: 8.h, color: Colors.grey),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 5.h),
                        MapVehiculo(details: details),
                        SizedBox(
                          height: 11.h,
                        ),
                        const Divider(),
                        SizedBox(
                          height: 2.h,
                        ),
                        const Upfields(text: 'Fotos del vehículo'),
                        SizedBox(
                          height: 6.h,
                        ),
                        FotosVehiculo(photos: photos),
                      ],
                    );
                  } else if (state is VehicleLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is VehicleError) {
                    return Center(
                      child: Text('Error: ${state.error}'),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _getAddressFromLatLng(double lat, double lon) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
    if (placemarks.isNotEmpty) {
      return '${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.country}';
    } else {
      return 'Dirección no encontrada';
    }
  }
}
