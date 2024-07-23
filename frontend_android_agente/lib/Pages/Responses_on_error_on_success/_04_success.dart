import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
const Color lightBlueColor = Color(0xFF009DD4); // Azul Claro
const Color darkBlueColor = Color(0xFF010F56); // Azul Oscuro
const Color greyTextColor = Color(0xFF494A4D); // Gris (Texto)

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // Fondo blanco.
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 14.h), // Alineación horizontal.
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Alineación centrada verticalmente.
            children: [
              SizedBox(height: 100.h), // Espacio vertical.
              Icon(
                Icons.check_circle_outline,
                color: Colors.green, // Color verde para indicar éxito.
                size: 100.h, // Tamaño del icono.
              ),
              SizedBox(
                  height: 20.h), // Espacio vertical entre el icono y el texto.
              Text(
                'Reporte creado\nexitosamente', // Mensaje de éxito.
                style: TextStyle(
                  fontSize: 14.h, // Tamaño de la fuente.
                  fontWeight: FontWeight.bold,
                  color: darkBlueColor, // Color del texto.
                ),
                textAlign: TextAlign.center, // Alineación centrada del texto.
              ),
              SizedBox(height: 200.h), // Espacio vertical.
              SizedBox(
                width: double.infinity, // Ancho completo del botón.
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/welcome',
                        (route) =>
                            false); // Navega a la pantalla de bienvenida y elimina las rutas anteriores.
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        vertical: 8.h), // Alineación vertical del botón.
                    backgroundColor:
                        const Color(0xFFF26522), // Color de fondo del botón.
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.h), // Bordes redondeados del botón.
                    ),
                  ),
                  child: Text(
                    'Aceptar', // Texto del botón.
                    style: TextStyle(
                      color: Colors.white, // Color del texto.
                      fontSize: 16.h, // Tamaño de la fuente.
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
