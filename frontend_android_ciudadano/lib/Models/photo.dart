class Photo {
  final String file;

  Photo({required this.file});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(file: json['File']);
  }

  Map<String, dynamic> toJson() {
    return {
      'File': file,
    };
  }
}
