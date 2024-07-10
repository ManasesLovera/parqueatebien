import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Controllers/Consulta/controller_consulta.dart';
import 'package:frontend_android/Pages/_01_Welcome/welcome.dart';
import 'package:frontend_android/Widgets/Consulta/plate_widget.dart';

class EnterPlateNumberScreen extends StatefulWidget {
  const EnterPlateNumberScreen({super.key});

  @override
  EnterPlateNumberScreenState createState() => EnterPlateNumberScreenState();
}

class EnterPlateNumberScreenState extends State<EnterPlateNumberScreen> {
  final EnterPlateNumberController _controller = EnterPlateNumberController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // Fondo blanco
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Welcome()),
              (Route<dynamic> route) => false,
            );
            return false;
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  Center(
                    child: Image.asset(
                      'assets/whiteback/main_w.png',
                      height: 50.h,
                    ),
                  ),
                  SizedBox(height: 65.h),
                  Center(
                    child: Text(
                      'Introduzca el número de placa de su vehículo',
                      style: TextStyle(
                        fontSize: 16.h,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Placa',
                      style: TextStyle(
                        color: const Color(0xFF010F56),
                        fontSize: 12.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  PlateWidgetConsulta(
                    controller: _controller.plateController,
                    touched: _controller.plateFieldTouched,
                    focusNode: FocusNode(),
                    onChanged: (value) {
                      setState(() {
                        _controller.plateFieldTouched = true;
                      });
                      _controller.checkInput(value);
                    },
                  ),
                  SizedBox(height: 270.h),
                  ValueListenableBuilder<bool>(
                    valueListenable: _controller.isButtonEnabled,
                    builder: (context, isEnabled, child) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isEnabled && !_controller.isLoading
                              ? () => _controller.searchVehicle(context)
                              : null,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.w),
                            backgroundColor: isEnabled && !_controller.isLoading
                                ? const Color(0xFF010F56) // Azul oscuro
                                : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: _controller.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : Text(
                                  'Consultar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.h,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
