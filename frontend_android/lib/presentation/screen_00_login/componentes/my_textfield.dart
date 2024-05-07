import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller; // controlamos la informacion en la caja de texto
  final String hintText; // pista guia para el usuario
  final bool obscuretext; // hide typing password data in the textfield

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscuretext});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscuretext,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
    );
  }
}
