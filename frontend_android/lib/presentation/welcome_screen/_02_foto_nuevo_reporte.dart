import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/componentes_visuales/Report_Buttons/photo_button.dart';

class NewReportPhotoScreen extends StatelessWidget {
  const NewReportPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.h),
          child: SingleChildScrollView(
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
                    'Fotos del vehiculo',
                    style: TextStyle(
                      fontSize: 16.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                //
                FotoButton(
                  onTap: () {},
                  icon: Icons.add_a_photo_rounded,
                  title: 'Agregar foto',
                  subtitle: '',
                ),
                //
                SizedBox(height: 80.h),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 0.w, vertical: 14.h),
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.grey[400]!, // Start color
                            Colors.grey[600]!, // End color
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 6.h),
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
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
