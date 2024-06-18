import 'package:frontend_android_ciudadano/entities/photo.dart';

class Car {
  final String licensePlate;
  final String status;
  final String vehicleType;
  final String vehicleColor;
  final String currentAddress;
  final String? reportedDate;
  final String? arrivalAtParkingLot;
  final List<Photo> photos;

  Car({
    required this.licensePlate,
    required this.status,
    required this.vehicleType,
    required this.vehicleColor,
    required this.currentAddress,
    this.reportedDate,
    this.arrivalAtParkingLot,
    required this.photos,
  });
}
