import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class VehicleDetailsScreen extends StatelessWidget {
  final List<XFile> imageFileList;

  const VehicleDetailsScreen({super.key, required this.imageFileList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Implement refresh functionality here
            },
          ),
        ],
        centerTitle: true,
        title: Image.asset(
          'assets/logo.png', // Replace with your logo asset path
          height: 40.h,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Center(
                  child: Text(
                    'Datos del vehículo',
                    style: TextStyle(
                      fontSize: 20.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10.h),
                Center(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20.h),
                    ),
                    child: Text(
                      'Vehículo retenido',
                      style: TextStyle(
                        fontSize: 16.h,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                _buildDetailItem(
                  title: 'Número de placa',
                  content: 'A8034464',
                ),
                _buildDetailItem(
                  title: 'Tipo de vehículo',
                  content: 'Automóvil',
                ),
                _buildDetailItem(
                  title: 'Color',
                  content: 'Negro',
                ),
                _buildDetailItem(
                  title: 'Ubicación de la retención',
                  content: 'C/Ricardo Soto #16, Naco, Santo Domingo',
                ),
                SizedBox(height: 20.h),
                Text(
                  'Fotos del vehículo',
                  style: TextStyle(
                    fontSize: 16.h,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 100.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imageFileList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Image.file(
                          File(imageFileList[index].path),
                          width: 100.w,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem({required String title, required String content}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        padding: EdgeInsets.all(10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(10.h),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14.h,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              content,
              style: TextStyle(
                fontSize: 14.h,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
