import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend_android/camera/camera_method/get_camera.dart';
import 'package:frontend_android/presentation/camera/send_screen_p3.dart';
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
    // Tamaño actual de la pantalla
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      // barra superior de la app
      appBar: AppBar(
        title: const Text("DEMO ORIONTEK"),
      ), // en columna
      body: Column(
        // centrada
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // para correguir los overflows en caso de orientacion de pantalla cambiada
          // al mismo tiempo aumentamos el recuadro de toma de foto. pantalla tomar foto.
          Expanded(
            child: Container(
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
                                  imageFile: imageFile!,
                                  mimeType: 'image/jpeg'),
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
                )),
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

  void setImageFile(File? file) {
    setState(() {
      imageFile = file;
    });
  }

  void showErrorCamera(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
