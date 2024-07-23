import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Controllers/Consulta/controller_consulta.dart';
import 'package:frontend_android/Handlers/Consulta/dialog_success_error_consulta.dart';
import 'package:frontend_android/Pages/_01_Welcome/welcome.dart';
import 'package:frontend_android/Widgets/Consulta/plate_widget.dart';
class EnterPlateNumberScreen extends StatefulWidget {
  const EnterPlateNumberScreen({super.key});

  @override
  EnterPlateNumberScreenState createState() => EnterPlateNumberScreenState();
}

class EnterPlateNumberScreenState extends State<EnterPlateNumberScreen> {
  final EnterPlateNumberController _controller =
      EnterPlateNumberController(); // Controlador de la pantalla.

  @override
  void dispose() {
    _controller.dispose(); // Libera los recursos del controlador.
    super.dispose();
  }

  // Método para mostrar un diálogo de error.
  void _showErrorDialog(String message) {
    showUniversalSuccessErrorDialogConsulta(context, message, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // Fondo blanco.
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Welcome()),
              (Route<dynamic> route) => false,
            );
            return false; // Previene que la pantalla sea removida automáticamente.
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: 14.w), // Alineación horizontal.
            child: Form(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Alineación izquierda.
                children: [
                  SizedBox(height: 30.h), // Espacio vertical.
                  Center(
                    child: Image.asset(
                      'assets/whiteback/main_w.png',
                      height: 50.h, // Altura de la imagen.
                    ),
                  ),
                  SizedBox(height: 65.h), // Espacio vertical.
                  Center(
                    child: Text(
                      'Introduzca el número de placa de su vehículo',
                      style: TextStyle(
                        fontSize: 16.h, // Tamaño de fuente.
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFF26522), // Color del texto.
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30.h), // Espacio vertical.
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Placa',
                      style: TextStyle(
                        color: const Color(0xFF010F56), // Color del texto.
                        fontSize: 12.h, // Tamaño de fuente.
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: PlateWidgetConsulta(
                      controller: _controller
                          .plateController, // Controlador del campo de texto.
                      touched: _controller
                          .plateFieldTouched, // Indica si el campo fue tocado.
                      focusNode: FocusNode(),
                      onChanged: (value) {
                        setState(() {
                          _controller.plateFieldTouched = true;
                        });
                        _controller.checkInput(
                            value); // Verifica el formato de la entrada.
                        // Habilita el botón inmediatamente cuando el campo tenga al menos un carácter.
                        if (value.isNotEmpty) {
                          _controller.isButtonEnabled.value = true;
                        } else {
                          _controller.isButtonEnabled.value = false;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 250.h), // Espacio vertical.
                  ValueListenableBuilder<bool>(
                    valueListenable: _controller
                        .isButtonEnabled, // Escucha cambios en el valor del botón.
                    builder: (context, isEnabled, child) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isEnabled && !_controller.isLoading
                              ? () {
                                  if (_controller
                                      .plateController.text.isEmpty) {
                                    _showErrorDialog(
                                        'Por favor ingrese un número de placa');
                                  } else if (!RegExp(r'^[A-Z][0-9]{6}$')
                                      .hasMatch(
                                          _controller.plateController.text)) {
                                    _showErrorDialog(
                                        'La placa debe empezar con una letra mayúscula seguida de 6 números');
                                  } else {
                                    _controller.searchVehicle(
                                        context); // Busca el vehículo.
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.w),
                            backgroundColor: isEnabled && !_controller.isLoading
                                ? const Color(
                                    0xFFF26522) // Color del botón habilitado.
                                : Colors.grey, // Color del botón deshabilitado.
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: _controller.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white) // Indicador de carga.
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
