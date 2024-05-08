import 'package:flutter/material.dart';
import 'package:frontend_android/componentes_visuales/my_button.dart';
import 'package:frontend_android/componentes_visuales/my_textfield.dart';
import 'package:frontend_android/login/login_method/login_method.dart';

class Login extends StatelessWidget {
  Login({super.key});
  //
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // fondo
      backgroundColor: Colors.grey[300],
      // retiramos notch
      body: SafeArea(
        //centramos
        child: Center(
          //en columna
          child: Column(
            children: [
              // separador de espacio
              const SizedBox(
                height: 50,
              ),
              // Icono de candado
              const Icon(
                Icons.lock,
                size: 100,
              ),
              // separador de espacio
              const SizedBox(
                height: 40,
              ),
              // Titulo debajo del candado
              Text(
                'Demo OrionTek',
                style: TextStyle(color: Colors.grey[700], fontSize: 20),
              ),
              // separador de espacio
              const SizedBox(
                height: 10,
              ),
              // Controlamos la caja de texto, con 'controller
              // presentamos el texto en la caja'
              MyTextField(
                controller: usernameController,
                hintText: 'Nombre De Usuario',
                obscuretext: false,
              ),
              // separador de espacio
              const SizedBox(
                height: 10,
              ),
              // Controlamos la caja de texto, con 'controller
              // no presentamos el texto en la caja porque es la contraseña'
              MyTextField(
                controller: passwordController,
                hintText: 'Contraseña',
                obscuretext: true,
              ),
              const SizedBox(
                height: 10,
              ),
              // relleno, en fila, 25px hacia la izquierda para que sea acrode
              // a la caja de texto userpassword
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
              // separador de espacio
              const SizedBox(
                height: 20,
              ), //Enviamos onTap Tap_Gestures
              // Como tambien el user y password capturados
              // context es para el navigator localization y estado del widget etc...
              MyButton(
                onTap: () =>
                    signUserIn(context, usernameController, passwordController),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
