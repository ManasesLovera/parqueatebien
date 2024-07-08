import 'photo.dart';

class Citizen {
  String registrationNumber;
  String licensePlate;
  String registrationDocument;
  String vehicleType;
  String vehicleColor;
  String model;
  String year;
  String reference;
  String status;
  String reportedBy;
  String reportedDate;
  String? towedByCraneDate;
  String? arrivalAtParkinglot;
  String? releaseDate;
  String? releasedBy;
  String lat;
  String lon;
  List<Photo> photos;

  Citizen({
    required this.registrationNumber,
    required this.licensePlate,
    required this.registrationDocument,
    required this.vehicleType,
    required this.vehicleColor,
    required this.model,
    required this.year,
    required this.reference,
    required this.status,
    required this.reportedBy,
    required this.reportedDate,
    this.towedByCraneDate,
    this.arrivalAtParkinglot,
    this.releaseDate,
    this.releasedBy,
    required this.lat,
    required this.lon,
    required this.photos,
  });

  factory Citizen.fromJson(Map<String, dynamic> json) => Citizen(
        registrationNumber: json["registrationNumber"],
        licensePlate: json["licensePlate"],
        registrationDocument: json["registrationDocument"],
        vehicleType: json["vehicleType"],
        vehicleColor: json["vehicleColor"],
        model: json["model"],
        year: json["year"],
        reference: json["reference"],
        status: json["status"],
        reportedBy: json["reportedBy"],
        reportedDate: json["reportedDate"],
        towedByCraneDate: json["towedByCraneDate"],
        arrivalAtParkinglot: json["arrivalAtParkinglot"],
        releaseDate: json["releaseDate"],
        releasedBy: json["releasedBy"],
        lat: json["lat"],
        lon: json["lon"],
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "registrationNumber": registrationNumber,
        "licensePlate": licensePlate,
        "registrationDocument": registrationDocument,
        "vehicleType": vehicleType,
        "vehicleColor": vehicleColor,
        "model": model,
        "year": year,
        "reference": reference,
        "status": status,
        "reportedBy": reportedBy,
        "reportedDate": reportedDate,
        "towedByCraneDate": towedByCraneDate,
        "arrivalAtParkinglot": arrivalAtParkinglot,
        "releaseDate": releaseDate,
        "releasedBy": releasedBy,
        "lat": lat,
        "lon": lon,
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
      };
}
