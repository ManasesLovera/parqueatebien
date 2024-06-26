import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/Vehiculo/_00_vehicle_event.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/Vehiculo/_01_vehicle_state.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/Vehiculo/_02_vehicle_bloc.dart';
import 'package:frontend_android_ciudadano/UI/Views/DatosVehiculoStatus/_02_detalles_info.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/GlobalsWidgets/_00_logo_image.dart';
import 'package:geocoding/geocoding.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          BlocBuilder<VehicleBloc, VehicleState>(
            builder: (context, state) {
              if (state is VehicleDetailsLoaded) {
                return IconButton(
                  icon: const Icon(Icons.info_outline, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ReportInfoScreen(vehicleData: state.vehicleDetails),
                      ),
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: () {
              // Handle refresh action
            },
          ),
        ],
        centerTitle: true,
        title: const CustomImageLogo(
          img: 'assets/whiteback/main_w.png',
          altura: 20,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Datos del vehículo',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                BlocBuilder<VehicleBloc, VehicleState>(
                  builder: (context, state) {
                    if (state is VehicleDetailsLoaded) {
                      final details = state.vehicleDetails;
                      final List<dynamic> photos = details['Photos'];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(details['Status'],
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          _buildDetailRow(
                              'Número de placa', details['LicensePlate']),
                          _buildDetailRow(
                              'Tipo de vehículo', details['VehicleType']),
                          _buildDetailRow('Color', details['VehicleColor']),
                          SizedBox(height: 20.h),
                          Text(
                            'Ubicación de la retención',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          FutureBuilder(
                            future: _getAddressFromLatLng(
                                double.parse(details['Lat']),
                                double.parse(details['Lon'])),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text('Cargando dirección...',
                                    style: TextStyle(fontSize: 16.sp));
                              } else if (snapshot.hasError) {
                                return Text('Error al obtener la dirección',
                                    style: TextStyle(fontSize: 16.sp));
                              } else {
                                return Text('${snapshot.data}',
                                    style: TextStyle(fontSize: 16.sp));
                              }
                            },
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            height: 200.h,
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
                          Text(
                            'Fotos del vehículo',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10.h),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: photos.map((photo) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 8.w),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.memory(
                                      base64Decode(photo['File']),
                                      height: 100.h,
                                      width: 100.w,
                                      fit: BoxFit.cover,
                                    ),
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

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16.sp),
          ),
        ],
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
