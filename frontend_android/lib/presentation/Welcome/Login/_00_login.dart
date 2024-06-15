import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Services/login/login_method.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _governmentIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 157, 210),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50.h),
                  Image.asset(
                    'assets/splash/main.png',
                    height: 100.h,
                  ),
                  SizedBox(height: 50.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.h),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Usuario',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 0.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.h, vertical: 1.h),
                    child: SizedBox(
                      height: 30.h,
                      child: TextField(
                        controller: _governmentIDController,
                        decoration: InputDecoration(
                          hintText: 'Ingresar número de cédula',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.h),
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
                        EdgeInsets.symmetric(horizontal: 14.h, vertical: 1.h),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Contraseña',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 1.h),
                    child: SizedBox(
                      height: 30.h,
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.remove_red_eye),
                          hintText: 'Ingresar la contraseña',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.h),
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
                  SizedBox(height: 16.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 0.h),
                    child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey[100]!,
                              Colors.grey[200]!,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            signUserIn(
                              context,
                              _governmentIDController,
                              _passwordController,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.h, vertical: 6.w),
                          ),
                          child: Text(
                            'Ingresar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.h,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/Forgot');
                    },
                    child: Text(
                      '¿Olvidaste La Contraseña?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 140.h),
                  Image.asset(
                    'assets/splash/bottom.png',
                    height: 50.h,
                  )
                ],
              ),
            )),
      ),
    );
  }
}
