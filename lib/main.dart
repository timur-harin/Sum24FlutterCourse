import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hydration App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        ),
      home: Scaffold(
      ),
    );
  }
}


