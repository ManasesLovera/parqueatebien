import 'package:flutter/material.dart';

/*
#009DD4 Azul Claro
#010F56 Azul Oscuro
#494A4D Gris (Texto)

  static const Color azulClaro = Color(0xFF009DD4);
  static const Color azulOscuro = Color(0xFF010F56);
  static const Color grisTexto = Color(0xFF494A4D);
*/
class MyTextField extends StatelessWidget {
  final dynamic controller;
  final String hintText;
  final bool obscuretext;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscuretext});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: TextField(
        controller: controller,
        obscureText: obscuretext,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xFF494A4D), fontSize: 14),
        ),
      ),
    );
  }
}
