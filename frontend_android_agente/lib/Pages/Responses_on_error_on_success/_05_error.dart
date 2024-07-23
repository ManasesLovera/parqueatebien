import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

const Color lightBlueColor = Color(0xFF009DD4); // Azul Claro
const Color darkBlueColor = Color(0xFF010F56); // Azul Oscuro
const Color greyTextColor = Color(0xFF494A4D); // Gris (Texto)

class ErrorScreen extends StatelessWidget {
  final String errorMessage; // Mensaje de error a mostrar.

  const ErrorScreen({super.key, required this.errorMessage});

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
            crossAxisAlignment: CrossAxisAlignment
                .center, // Alineación centrada horizontalmente.
            children: [
              SizedBox(height: 120.h), // Espacio vertical.
              SvgPicture.asset(
                'assets/icons/error.svg',
                height: 100.h, // Altura de la imagen SVG.
              ),
              SizedBox(height: 20.h), // Espacio vertical.
              Text(
                'Error al crear reporte', // Título del mensaje de error.
                style: TextStyle(
                  fontSize: 14.h, // Tamaño de la fuente.
                  fontWeight: FontWeight.bold,
                  color: darkBlueColor, // Color del texto.
                ),
                textAlign: TextAlign.center, // Alineación centrada del texto.
              ),
              SizedBox(height: 20.h), // Espacio vertical.
              Text(
                errorMessage, // Mensaje de error dinámico.
                style: TextStyle(
                  fontSize: 14.h, // Tamaño de la fuente.
                  color: Colors.black, // Color del texto.
                ),
                textAlign: TextAlign.center, // Alineación centrada del texto.
              ),
              SizedBox(height: 215.h), // Espacio vertical.
              SizedBox(
                width: double.infinity, // Ancho completo del botón.
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Vuelve a la pantalla anterior.
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        vertical: 8.h), // Alineación vertical del botón.
                    backgroundColor: darkBlueColor, // Color de fondo del botón.
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.h), // Bordes redondeados del botón.
                    ),
                  ),
                  child: Text(
                    'Reintentar', // Texto del botón.
                    style: TextStyle(
                      color: Colors.white, // Color del texto.
                      fontSize: 16.h, // Tamaño de la fuente.
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h), // Espacio vertical.
            ],
          ),
        ),
      ),
    );
  }
}
