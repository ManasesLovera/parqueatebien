import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/back.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/main.png',
                  width: 75,
                  height: 74,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // Branding Image
          Positioned(
            bottom: 0, // Adjust position as needed
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/bottom.png',
                width: 75,
                height: 75,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
