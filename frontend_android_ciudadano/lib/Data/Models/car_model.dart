

class Vehicle {
  final String licensePlate;
  final String registrationDocument;
  final String model;
  final String year;
  final String color;

  Vehicle({
    required this.licensePlate,
    required this.registrationDocument,
    required this.model,
    required this.year,
    required this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      'licensePlate': licensePlate,
      'registrationDocument': registrationDocument,
      'model': model,
      'year': year,
      'color': color,
    };
  }
}
