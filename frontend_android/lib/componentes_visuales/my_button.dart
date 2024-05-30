import 'package:flutter/material.dart';

/*
#009DD4 Azul Claro
#010F56 Azul Oscuro
#494A4D Gris (Texto)

  static const Color azulClaro = Color(0xFF009DD4);
  static const Color azulOscuro = Color(0xFF010F56);
  static const Color grisTexto = Color(0xFF494A4D);
*/
class MyButton extends StatelessWidget {
  final Function()? onTap; // para nuestro GestureDetector
  const MyButton({super.key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // onTap
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF494A4D),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            'Ingresar',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
