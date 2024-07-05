import 'package:frontend_android_ciudadano/Data/Models/car_model.dart';

class User {
  final String governmentId;
  final String name;
  final String lastname;
  final String email;
  final String password;
  final List<Vehicle> vehicles;

  User({
    required this.governmentId,
    required this.name,
    required this.lastname,
    required this.email,
    required this.password,
    required this.vehicles,
  });

  Map<String, dynamic> toJson() {
    return {
      'governmentId': governmentId.replaceAll('-', ''),
      'name': name,
      'lastname': lastname,
      'email': email,
      'password': password,
      'vehicles': vehicles.map((v) => v.toJson()).toList(),
    };
  }
}
