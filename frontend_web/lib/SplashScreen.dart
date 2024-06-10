import 'package:flutter/material.dart';
import 'package:web/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainApp()));
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/fondo_splash.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/image/LOGO_PARQUEATE.png',
                  height: 200, // Ajusta el tamaño de la imagen según sea necesario
                ),
              ),
              SizedBox(height: 20), 
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/image/LOGO_INTRANT.png',
                height: 50, // Ajusta el tamaño de la tercera imagen según sea necesario
              ),
            ),
          ),
        ],
      ),
    );
  }
}