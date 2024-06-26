import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/Vehiculo/_01_vehicle_state.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/Vehiculo/_02_vehicle_bloc.dart';
import 'package:frontend_android_ciudadano/UI/Widgets/GlobalsWidgets/_00_logo_image.dart';

class CarDetails extends StatelessWidget {
  const CarDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: Column(
              children: [
                SizedBox(height: 30.h),
                const Center(
                  child: CustomImageLogo(
                    img: 'assets/whiteback/main_w.png',
                    altura: 60,
                  ),
                ),
                BlocBuilder<VehicleBloc, VehicleState>(
                  builder: (context, state) {
                    if (state is VehicleDetailsLoaded) {
                      final details = state.vehicleDetails;
                      return Column(
                        children: [
                          Text("License Plate: ${details['licensePlate']}"),
                          Text("Vehicle Type: ${details['vehicleType']}"),
                          Text("Vehicle Color: ${details['vehicleColor']}"),
                          Text("Status: ${details['status']}"),
                          Text("Reported By: ${details['reportedBy']}"),
                          Text("Reported Date: ${details['reportedDate']}"),
                          // Add more details as needed
                        ],
                      );
                    } else if (state is VehicleLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is VehicleError) {
                      return Text('Error: ${state.error}');
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
