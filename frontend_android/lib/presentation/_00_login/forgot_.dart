import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Forgot extends StatelessWidget {
  const Forgot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 157, 210),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50.h),
                  Image.asset(
                    'assets/main.png',
                    height: 100.h,
                    //  width: double.infinity,
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Olvidaste tu\n'
                        'contraseña?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.h,
                          //    fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'ingresa tu Usuario para recibir instrucciones'
                        ' de como recuperar tu contraseña.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.h,
                          // fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Usuario',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
                    child: SizedBox(
                      height: 30.h,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Ingresar número de cédula',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 13.h,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r)),
                            borderSide: const BorderSide(color: Colors.white70),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r)),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 0),
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
                            'Recuperar',
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
                  SizedBox(height: 100.h),
                  Image.asset(
                    'assets/bottom.png',
                    height: 50.h,
                  )
                ],
              ),
            )),
      ),
    );
  }
}
