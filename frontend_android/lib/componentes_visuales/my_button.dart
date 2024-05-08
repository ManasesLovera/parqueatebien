import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap; // para nuestro GestureDetector
  const MyButton({super.key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(  // 
      onTap: onTap, // onTap
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            'Iniciar Sesión',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
