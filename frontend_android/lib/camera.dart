import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:frontend_android/send_data.dart'; // Import the DisplayImageScreen

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  File? imageFile;
  //String? mimeType;

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
            height: 500,
            child: GestureDetector(
              onTap: () {
            //    if (imageFile != null && mimeType != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SendData(
                        imageFile: imageFile!,
                         mimeType: 'image/jpeg'
                    //    mimeType: mimeType!,
                      ),
                    ),
                  );
       //         }
              },
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                color: Colors.blueGrey,
                strokeWidth: 1,
                dashPattern: const [10, 5],
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
                      getFromCamera();
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

  // get from camera
  Future<void> getFromCamera() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
   //     mimeType = pickedFile.mimeType;
      });
    }
  }
}
