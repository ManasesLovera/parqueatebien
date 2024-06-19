import '../entities/car.dart';
import 'photo_model.dart';

class CarModel extends Car {
  const CarModel({
    required super.licensePlate,
    required super.status,
    required super.vehicleType,
    required super.vehicleColor,
    required super.currentAddress,
    super.reportedDate,
    super.arrivalAtParkingLot,
    required List<PhotoModel> super.photos,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    var photosFromJson = json['Photos'] as List;
    List<PhotoModel> photoList =
        photosFromJson.map((photo) => PhotoModel.fromJson(photo)).toList();

    return CarModel(
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
      'Photos': photos.map((photo) => (photo as PhotoModel).toJson()).toList(),
    };
  }
}
