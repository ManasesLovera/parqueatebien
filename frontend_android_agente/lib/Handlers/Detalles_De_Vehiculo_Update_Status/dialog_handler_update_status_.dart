import 'package:flutter/material.dart';
void showUniversalSuccessErrorDialogEstatus(
    BuildContext context, String message, bool isSuccess) {
  showDialog(
    context: context,
    barrierDismissible:
        false, // Evita que el diálogo se cierre al tocar fuera de él.
    builder: (BuildContext context) {
      // Cierra el diálogo automáticamente después de 2 segundos.
      Future.delayed(const Duration(seconds: 2), () {
        if (context.mounted) {
          Navigator.of(context)
              .pop(true); // Cierra el diálogo si el contexto está montado.
        }
      });

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20), // Bordes redondeados para el diálogo.
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Espaciado interno del diálogo.
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSuccess
                    ? Icons.check_circle
                    : Icons.error, // Icono de éxito o error.
                color: isSuccess
                    ? Colors.green
                    : Colors.red, // Color del icono basado en el éxito o error.
                size: 80, // Tamaño del icono.
              ),
              const SizedBox(height: 20), // Espaciado vertical.
              Text(
                message, // Mensaje a mostrar.
                textAlign: TextAlign.center, // Alineación centrada del texto.
                style: const TextStyle(
                  fontSize: 18, // Tamaño de fuente del texto.
                  fontWeight: FontWeight.w600, // Peso de fuente del texto.
                  color: Colors.black87, // Color del texto.
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
