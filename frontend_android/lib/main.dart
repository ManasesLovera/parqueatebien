import 'package:flutter/material.dart';
import 'package:frontend_android/camera.dart';
//import 'package:http/http.dart' as http;

void main() async {
  runApp(const MyApp());
  /*
  const app = MainApp();
  app.pokeUri();
  runApp(app);
  */
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
/*
  Future<void> pokeUri() async {
    final httpPackageUrl = Uri.http('localhost:8089', '/');
    final httpPackageInfo = await http.read(httpPackageUrl);
    print(httpPackageInfo);
  }
  */

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Retiramos el debug icon
      debugShowCheckedModeBanner: false,
      home: MyPage(),
    );
  }
}
