import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Forgot extends StatelessWidget {
  const Forgot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF010F56), // Color de fondo de la pantalla.
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 2.h), // Alineación horizontal.
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Alineación centrada.
              children: [
                SizedBox(height: 50.h), // Espacio vertical.
                Image.asset(
                  'assets/logo/logo.png',
                  height: 95.h, // Altura de la imagen del logo.
                ),
                SizedBox(height: 30.h), // Espacio vertical.
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 14.w), // Alineación horizontal.
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Olvidaste tu contraseña?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.h, // Tamaño de fuente.
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 15.h), // Espacio vertical.
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 14.w), // Alineación horizontal.
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Ingresa tu Usuario para recibir instrucciones de como recuperar tu contraseña.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.h, // Tamaño de fuente.
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 20.h), // Espacio vertical.
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 14.w), // Alineación horizontal.
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Usuario',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.h, // Tamaño de fuente.
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 2.h), // Alineación horizontal y vertical.
                  child: SizedBox(
                    height: 30.h, // Altura del campo de texto.
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Ingresar número de cédula',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.h, // Tamaño de fuente del hint.
                        ),
                        filled: true,
                        fillColor:
                            Colors.white, // Color de fondo del campo de texto.
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.r)), // Bordes redondeados.
                          borderSide: const BorderSide(color: Colors.white70),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.r)), // Bordes redondeados.
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                      style: const TextStyle(
                          color: Colors
                              .black), // Color de texto del campo de texto.
                    ),
                  ),
                ),
                SizedBox(height: 20.h), // Espacio vertical.
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 14.w, vertical: 0), // Alineación horizontal.
                  child: SizedBox(
                    width: double.infinity, // Ancho del botón.
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.grey[100]!, // Color de inicio del gradiente.
                            Colors.grey[200]!, // Color de fin del gradiente.
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius:
                            BorderRadius.circular(10.r), // Bordes redondeados.
                      ),
                      child: ElevatedButton(
                        onPressed:
                            () {}, // Acción del botón (actualmente vacía).
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.transparent, // Fondo transparente.
                          shadowColor:
                              Colors.transparent, // Sombra transparente.
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.r), // Bordes redondeados.
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w,
                              vertical: 6.h), // Alineación interna del botón.
                        ),
                        child: Text(
                          'Recuperar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.h, // Tamaño de fuente.
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 135.h), // Espacio vertical.
                Image.asset(
                  'assets/splash/bottom.png',
                  height: 50.h, // Altura de la imagen inferior.
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
