import 'package:flutter/material.dart';
import 'package:frontend_android/presentation/screen_00_login/componentes/my_textfield.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //fondo
      backgroundColor: Colors.grey[300],
      //retiramos noth
      body: SafeArea(
        //centramos
        child: Center(
          // todo en columna
          child: Column(
            children: [
              //spaciamos el lock icon
              const SizedBox(
                height: 50,
              ),
              // logo lock icon
              const Icon(
                Icons.lock,
                size: 125,
              ),
              //Spaciamos el lock icon
              const SizedBox(
                height: 50,
              ),
              // Subtitulo lock Icon
              Text(
                'Sistema Demo OrionTek',
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
              //Spaciamos el subtitulo del texbox a continuacion.
              const SizedBox(
                height: 10,
              ),
              MyTextField(),
              const SizedBox(
                height: 10,
              ),
              MyTextField(),
              // Rellenos horizontal
            ],
          ),
        ),
      ),
    );
  }
}
