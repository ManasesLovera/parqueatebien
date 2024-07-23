import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:frontend_android/Pages/_02_1_Reporte/_03_confirmation.dart';

const Color lightBlueColor = Color(0xFF009DD4); // Azul Claro
const Color darkBlueColor = Color(0xFF010F56); // Azul Oscuro
const Color greyTextColor = Color(0xFF494A4D); // Gris (Texto)

class PhotoScreen extends StatefulWidget {
  final String plateNumber;
  final String vehicleType;
  final String color;
  final String address;
  final String? latitude;
  final String? longitude;

  const PhotoScreen({
    super.key,
    required this.plateNumber,
    required this.vehicleType,
    required this.color,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  @override
  NewReportPhotoScreenState createState() => NewReportPhotoScreenState();
}

class NewReportPhotoScreenState extends State<PhotoScreen> {
  final ImagePicker _picker =
      ImagePicker(); // Instancia del selector de imágenes.
  final List<XFile> _imageFileList =
      []; // Lista de archivos de imágenes seleccionadas.

  // Método para seleccionar imágenes usando la cámara.
  void _pickImages() async {
    if (_imageFileList.length < 5) {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50, // Calidad de la imagen.
        preferredCameraDevice: CameraDevice.rear, // Cámara trasera.
      );

      if (image != null) {
        setState(() {
          _imageFileList.add(image); // Añade la imagen a la lista.
        });
      }
    } else {
      showUniversalSuccessErrorDialogPhotos(
          context,
          'No se permiten más de 5 fotos',
          false); // Muestra un diálogo si se excede el límite de fotos.
    }
  }

  // Método para navegar a la pantalla de confirmación.
  void _navigateToConfirmation() {
    if (_imageFileList.length >= 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationScreen(
            plateNumber: widget.plateNumber,
            vehicleType: widget.vehicleType,
            color: widget.color,
            address: widget.address,
            latitude: widget.latitude,
            longitude: widget.longitude,
            imageFileList: _imageFileList,
          ),
        ),
      );
    } else {
      showUniversalSuccessErrorDialogPhotos(
          context,
          'Debe agregar al menos 3 fotos',
          false); // Muestra un diálogo si no se añaden suficientes fotos.
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(); // Navega hacia atrás.
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF), // Fondo blanco.
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h), // Espacio vertical.
                Center(
                  child: Text(
                    'Nuevo reporte',
                    style: TextStyle(
                      fontSize: 19.h,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFF26522),
                    ),
                  ),
                ),
                SizedBox(height: 18.h), // Espacio vertical.
                Center(
                  child: Text(
                    'Fotos del vehículo',
                    style: TextStyle(
                      fontSize: 14.h,
                      fontWeight: FontWeight.bold,
                      color: greyTextColor,
                    ),
                  ),
                ),
                SizedBox(height: 14.h), // Espacio vertical.
                Center(
                  child: Column(
                    children: [
                      FotoButton(
                        onTap: _pickImages, // Acción al tocar el botón de foto.
                        iconPath:
                            'assets/icons/add.svg', // Ruta del icono del botón.
                        title: 'Agregar foto', // Título del botón.
                      ),
                      SizedBox(height: 8.h), // Espacio vertical.
                      Text(
                        'Minimo 3 fotos. maximo 5 fotos',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.h,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h), // Espacio vertical.
                Expanded(
                  child: _imageFileList.isNotEmpty
                      ? ListView.builder(
                          itemCount: _imageFileList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 0.h,
                                vertical: 4.h,
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFF010F56),
                                        width:
                                            3.0, // Grosor del borde aumentado.
                                      ),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Image.file(
                                        File(_imageFileList[index].path),
                                        width: double.infinity,
                                        height: 100.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _imageFileList.removeAt(
                                              index); // Elimina la foto de la lista.
                                          showUniversalSuccessErrorDialogPhotos(
                                              context,
                                              'Foto eliminada',
                                              true); // Muestra un diálogo confirmando la eliminación.
                                        });
                                      },
                                      child: SvgPicture.asset(
                                        'assets/icons/editar.svg',
                                        height: 24.h,
                                        width: 24.w,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/photo.svg',
                                height: 30.h,
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                'Sin fotos agregadas',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10.h,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                SizedBox(height: 20.h), // Espacio vertical.
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.h),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _imageFileList.length >= 3
                          ? _navigateToConfirmation // Navega a la confirmación si hay al menos 3 fotos.
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        backgroundColor: _imageFileList.length >= 3
                            ? const Color(
                                0xFFF26522) // Botón habilitado si hay al menos 3 fotos.
                            : Colors
                                .grey, // Botón deshabilitado si hay menos de 3 fotos.
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.h),
                        ),
                      ),
                      child: Text(
                        'Finalizar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h), // Espacio vertical.
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Botón personalizado para añadir fotos.
class FotoButton extends StatelessWidget {
  final VoidCallback onTap;
  final String iconPath;
  final String title;

  const FotoButton({
    super.key,
    required this.onTap,
    required this.iconPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 10.w),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFF26522), width: 1.3.h),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(
                iconPath,
                height: 24.h,
                colorFilter: const ColorFilter.mode(
                  Color(0xFFF26522),
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                title,
                style: TextStyle(
                  color: darkBlueColor,
                  fontSize: 14.h,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Método para mostrar un diálogo de éxito o error al agregar/eliminar fotos.
void showUniversalSuccessErrorDialogPhotos(
    BuildContext context, String message, bool isSuccess) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context)
            .pop(true); // Cierra el diálogo después de 2 segundos.
      });

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSuccess
                    ? Icons.check_circle
                    : Icons.error, // Icono de éxito o error.
                color: isSuccess
                    ? Colors.green
                    : Colors.red, // Color del icono basado en el resultado.
                size: 80,
              ),
              const SizedBox(height: 20),
              Text(
                message, // Mensaje a mostrar.
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
