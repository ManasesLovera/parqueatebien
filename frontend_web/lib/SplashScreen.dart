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
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/fondo_splash.png'),
              fit: BoxFit.cover, 
            ),
          ),
          child: Center(
           child: Image.asset('assets/image/LOGO_PARQUEATE.png',
            ),
          ),
        ),
      );
  }
}