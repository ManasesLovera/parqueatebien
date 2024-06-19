import 'package:equatable/equatable.dart';
import 'photo.dart';

abstract class Car extends Equatable {
  final String licensePlate;
  final String status;
  final String vehicleType;
  final String vehicleColor;
  final String currentAddress;
  final String? reportedDate;
  final String? arrivalAtParkingLot;
  final List<Photo> photos;

  const Car({
    required this.licensePlate,
    required this.status,
    required this.vehicleType,
    required this.vehicleColor,
    required this.currentAddress,
    this.reportedDate,
    this.arrivalAtParkingLot,
    required this.photos,
  });

  @override
  List<Object?> get props => [
        licensePlate,
        status,
        vehicleType,
        vehicleColor,
        currentAddress,
        reportedDate,
        arrivalAtParkingLot,
        photos,
      ];
}
