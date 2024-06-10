import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:frontend_android/presentation/_01_Reporte/_03_confirmation_screen.dart';

class NewReportPhotoScreen extends StatefulWidget {
  final String plateNumber;
  final String vehicleType;
  final String color;
  final String address;
  final String? latitude;
  final String? longitude;

  const NewReportPhotoScreen({
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

class NewReportPhotoScreenState extends State<NewReportPhotoScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _imageFileList = [];

  void _pickImages() async {
    if (_imageFileList.length < 5) {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (image != null) {
        setState(() {
          _imageFileList.add(image);
        });
      }
    }
  }

  void _navigateToConfirmation() {
    if (_imageFileList.length >= 3) {
      Navigator.push(
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debe agregar al menos 3 fotos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  'Nuevo reporte',
                  style: TextStyle(
                    fontSize: 24.h,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  'Fotos del vehículo',
                  style: TextStyle(
                    fontSize: 16.h,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: FotoButton(
                  onTap: _pickImages,
                  icon: Icons.add_a_photo_rounded,
                  title: 'Agregar foto',
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: _imageFileList.isNotEmpty
                    ? ListView.builder(
                        itemCount: _imageFileList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.file(
                                      File(_imageFileList[index].path),
                                      width: double.infinity,
                                      height: 200.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        _imageFileList.removeAt(index);
                                      });
                                    },
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
                            Icon(
                              Icons.image,
                              size: 50.h,
                              color: Colors.grey,
                            ),
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.h),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _navigateToConfirmation,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                    ),
                    child: Text(
                      'Continuar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

class FotoButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String title;

  const FotoButton({
    super.key,
    required this.onTap,
    required this.icon,
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
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(icon, color: Colors.blue, size: 24.h),
              SizedBox(height: 8.h),
              Text(
                title,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18.h,
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