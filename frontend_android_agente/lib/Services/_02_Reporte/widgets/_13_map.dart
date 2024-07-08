import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Services/_02_Reporte/api/location_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  GoogleMapController? _controller;
  Position? _currentPosition;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position? position = await LocationService().getCurrentLocation(
        (message) => _showLocationDialog(context, message),
      );
      if (position != null) {
        setState(() {
          _currentPosition = position;
          _markers.add(Marker(
            markerId: const MarkerId('currentLocation'),
            position: LatLng(position.latitude, position.longitude),
          ));
          _isLoading = false;
        });

        Position destination = Position(
          latitude: 19.4582039726578,
          longitude: -70.68415495829865,
          timestamp: DateTime.now(),
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
          altitudeAccuracy: 0.0,
          headingAccuracy: 0.0,
        );

        setState(() {
          _markers.add(Marker(
            markerId: const MarkerId('destination'),
            position: LatLng(destination.latitude, destination.longitude),
          ));
        });

        _addPolyline(position, destination);
      } else {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
      debugPrint('Error fetching current location: $e');
    }
  }

  void _showLocationDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false, // No permitir cerrar el diálogo tocando fuera
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Servicios de Ubicación'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openLocationSettings()
                    .then((_) => _getCurrentLocation());
              },
            ),
          ],
        );
      },
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    if (_currentPosition != null) {
      _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        zoom: 13.0,
      )));
    }
  }

  void _addPolyline(Position start, Position end) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'YOUR_API_KEY',
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(end.latitude, end.longitude),
    );

    if (result.points.isNotEmpty) {
      List<LatLng> points = result.points.map((point) {
        return LatLng(point.latitude, point.longitude);
      }).toList();

      setState(() {
        _polylines.add(Polyline(
          polylineId: const PolylineId('route'),
          points: points,
          color: Colors.blue,
          width: 5,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasError) {
      return const Center(child: Text('Failed to load location'));
    }

    return SizedBox(
        height: 150.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0.r),
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentPosition != null
                    ? LatLng(
                        _currentPosition!.latitude, _currentPosition!.longitude)
                    : const LatLng(0, 0),
                zoom: 13.0,
              ),
              markers: _markers,
              polylines: _polylines,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),
        ));
  }
}
