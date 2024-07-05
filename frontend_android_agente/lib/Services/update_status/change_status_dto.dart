class ChangeStatusDTO {
  final String licensePlate;
  final String newStatus;
  final String username;

  ChangeStatusDTO({
    required this.licensePlate,
    required this.newStatus,
    required this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      'licensePlate': licensePlate,
      'newStatus': newStatus,
      'username': username,
    };
  }
}
