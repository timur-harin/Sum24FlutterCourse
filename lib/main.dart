import 'package:education/templates/lab1/lab1.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Lab1());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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