import 'package:flutter/material.dart';
import 'package:frontend_android/componentes_visuales/my_button.dart';
import 'package:frontend_android/componentes_visuales/my_textfield.dart';
import 'package:frontend_android/login/login_method/login_method.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Demo OrionTek',
                style: TextStyle(color: Colors.grey[700], fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                controller: usernameController,
                hintText: 'Nombre De Usuario',
                obscuretext: false,
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                controller: passwordController,
                hintText: 'Contraseña',
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
              MyButton(
                // Iniciar...
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
