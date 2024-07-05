class Vehicle {
  final String governmentId;
  final String licensePlate;
  final String registrationDocument;
  final String model;
  final String year;
  final String color;

  Vehicle({
    required this.governmentId,
    required this.licensePlate,
    required this.registrationDocument,
    required this.model,
    required this.year,
    required this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      'governmentId': governmentId.replaceAll('-', ''),
      'licensePlate': licensePlate,
      'registrationDocument': registrationDocument,
      'model': model,
      'year': year,
      'color': color,
    };
  }
}
