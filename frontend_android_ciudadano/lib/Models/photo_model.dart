import 'package:frontend_android_ciudadano/entities/photo.dart';

class PhotoModel extends Photo {
  PhotoModel({required super.file});

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(file: json['File']);
  }

  Map<String, dynamic> toJson() {
    return {
      'File': file,
    };
  }
}
