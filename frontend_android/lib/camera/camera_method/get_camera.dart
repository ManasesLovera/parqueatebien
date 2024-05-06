import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraMethods {
  static Future<void> getFromCamera(
    BuildContext context,
    ImagePicker imagePicker,
    Function(File?) setImageFile,
    Function(String) showError,
  ) async {
    try {
      final pickedFile = await imagePicker.pickImage(
        source: ImageSource.camera,
      );
      if (pickedFile != null) {
        setImageFile(File(pickedFile.path));
      } else {
        showError('Su Dispositivo no Cuenta con una Cámara Disponible.');
      }
    } catch (e) {
      showError('No se pudo Acceder a la Cámara.');
    }
  }
}
