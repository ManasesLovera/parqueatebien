class Photo {
  String fileType;
  String file;

  Photo({
    required this.fileType,
    required this.file,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        fileType: json["fileType"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "fileType": fileType,
        "file": file,
      };
}
