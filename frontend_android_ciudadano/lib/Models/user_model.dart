import 'package:frontend_android_ciudadano/Models/car_model.dart';

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

  // Convierte el objeto User a un mapa JSON
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
