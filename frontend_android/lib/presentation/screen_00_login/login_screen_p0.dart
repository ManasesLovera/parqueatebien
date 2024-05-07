import 'package:flutter/material.dart';
import 'package:frontend_android/presentation/screen_00_login/componentes/my_button.dart';
import 'package:frontend_android/presentation/screen_00_login/componentes/my_textfield.dart';

class Login extends StatelessWidget {
  Login({super.key});

  // for usernameControllers TextFields
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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
                size: 100,
              ),
              //Spaciamos el lock icon
              const SizedBox(
                height: 40,
              ),
              // Subtitulo lock Icon
              Text(
                'Sistema Demo OrionTek',
                style: TextStyle(color: Colors.grey[700], fontSize: 20),
              ),
              //Spaciamos el subtitulo del texbox a continuacion.
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                //Controller Username
                controller: usernameController,
                hintText: 'Nombre De Usuario',
                // Ocultamos
                obscuretext: false,
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                // Password
                controller: passwordController,
                hintText: 'Contraseña',
                // Mostramos
                obscuretext: true,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Olvido Su Contraseña ?',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12.5),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              const MyButton(),
            ],
          ),
        ),
      ),
    );
  }
}
