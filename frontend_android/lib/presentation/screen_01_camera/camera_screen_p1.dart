import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend_android/camera/camera_method/get_camera.dart';
import 'package:frontend_android/presentation/screen_03_send/send_screen_p3.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  CameraState createState() => CameraState();
}

class CameraState extends State<Camera> {
  File? imageFile;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("AMET"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            width: size.width,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blueGrey,
                width: 2.5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: GestureDetector(
              onTap: imageFile != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SendData(
                              imageFile: imageFile!, mimeType: 'image/jpeg'),
                        ),
                      );
                    }
                  : null,
              child: SizedBox.expand(
                child: FittedBox(
                  child: imageFile != null
                      ? Image.file(imageFile!, fit: BoxFit.cover)
                      : const Icon(
                          Icons.image_outlined,
                          color: Colors.blueGrey,
                        ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 20),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: size.width,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blueGrey,
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      // Metodo Restructurado
                      CameraMethods.getFromCamera(
                        context,
                        _imagePicker,
                        setImageFile,
                        showErrorCamera,
                      );
                    },
                    child: const Center(
                      child: Text(
                        'Tomar Foto',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// Fix
  void setImageFile(File? file) {
    setState(() {
      imageFile = file;
    });
  }

//
  void showErrorCamera(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
