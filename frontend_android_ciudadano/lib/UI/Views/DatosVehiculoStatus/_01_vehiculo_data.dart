import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/Vehiculo/_00_vehicle_event.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/Vehiculo/_01_vehicle_state.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/Vehiculo/_02_vehicle_bloc.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/GlobalsWidgets/_00_logo_image.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarDetails extends StatelessWidget {
  final String licensePlate;

  const CarDetails({super.key, required this.licensePlate});

  @override
  Widget build(BuildContext context) {
    // Fetch details when the page is opened
    BlocProvider.of<VehicleBloc>(context)
        .add(FetchVehicleDetails(licensePlate));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                const Center(
                  child: CustomImageLogo(
                    img: 'assets/whiteback/main_w.png',
                    altura: 20,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Datos del vehículo',
                  style: TextStyle(fontSize: 18.h, fontWeight: FontWeight.bold),
                ),
                BlocBuilder<VehicleBloc, VehicleState>(
                  builder: (context, state) {
                    if (state is VehicleDetailsLoaded) {
                      final details = state.vehicleDetails;
                      final List<dynamic> photos = details['Photos'];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          Text('Número de placa',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold)),
                          Text(details['LicensePlate'],
                              style: TextStyle(fontSize: 16.h)),
                          SizedBox(height: 10.h),
                          Text('Tipo de vehículo',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold)),
                          Text(details['VehicleType'],
                              style: TextStyle(fontSize: 16.h)),
                          SizedBox(height: 10.h),
                          Text('Color',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold)),
                          Text(details['VehicleColor'],
                              style: TextStyle(fontSize: 16.h)),
                          SizedBox(height: 20.h),
                          Text('Ubicación de la retención',
                              style: TextStyle(
                                  fontSize: 16.h, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10.h),
                          SizedBox(
                            height: 100.h,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(double.parse(details['Lat']),
                                    double.parse(details['Lon'])),
                                zoom: 14.0,
                              ),
                              markers: {
                                Marker(
                                  markerId: const MarkerId('Location'),
                                  position: LatLng(double.parse(details['Lat']),
                                      double.parse(details['Lon'])),
                                ),
                              },
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text('Fotos del vehículo',
                              style: TextStyle(
                                  fontSize: 16.h, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10.h),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: photos.map((photo) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 8.w),
                                  child: Image.memory(
                                    base64Decode(photo['File']),
                                    height: 100.h,
                                    width: 100.w,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      );
                    } else if (state is VehicleLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is VehicleError) {
                      return Center(child: Text('Error: ${state.error}'));
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
