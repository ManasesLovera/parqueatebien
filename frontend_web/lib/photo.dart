// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'main.dart'; 
//  class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
    
//     Timer(Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => MainApp()), 
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/splash.fondo.jpg'), // Ruta de la imagen de fondo
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset('frontend_web/build/web/assets/image/main.dart.logo.png'), // Imagen del logo
//               SizedBox(height: 20), // Espacio entre el logo y el texto (opcional)
//               Text(
//                 '',
//                 style: TextStyle(fontSize: 24, color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }