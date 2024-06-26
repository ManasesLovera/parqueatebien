import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapVehiculo extends StatelessWidget {
  const MapVehiculo({
    super.key,
    required this.details,
  });

  final Map<String, dynamic> details;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            double.parse(details['Lat']),
            double.parse(details['Lon']),
          ),
          zoom: 16,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('Location'),
            position: LatLng(
              double.parse(details['Lat']),
              double.parse(details['Lon']),
            ),
          ),
        },
      ),
    );
  }
}
