import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  const app = MainApp();
  app.pokeUri();
  runApp(app);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Future<void> pokeUri() async {
    final httpPackageUrl = Uri.http('localhost:8089', '/');
    final httpPackageInfo = await http.read(httpPackageUrl);
    print(httpPackageInfo);
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
