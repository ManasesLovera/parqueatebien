import 'package:frontend_android_ciudadano/Models/photo.dart';

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
  factory Car.fromJson(Map<String, dynamic> json) {
    var photosFromJson = json['Photos'] as List;
    List<Photo> photoList =
        photosFromJson.map((photo) => Photo.fromJson(photo)).toList();

    return Car(
      licensePlate: json['LicensePlate'],
      status: json['Status'],
      vehicleType: json['VehicleType'],
      vehicleColor: json['VehicleColor'],
      currentAddress: json['CurrentAddress'],
      reportedDate: json['ReportedDate'],
      arrivalAtParkingLot: json['ArrivalAtParkingLot'],
      photos: photoList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'LicensePlate': licensePlate,
      'Status': status,
      'VehicleType': vehicleType,
      'VehicleColor': vehicleColor,
      'CurrentAddress': currentAddress,
      'ReportedDate': reportedDate,
      'ArrivalAtParkingLot': arrivalAtParkingLot,
      'Photos': photos.map((photo) => photo.toJson()).toList(),
    };
  }
}
