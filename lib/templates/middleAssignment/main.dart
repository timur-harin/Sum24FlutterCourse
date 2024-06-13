import 'home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MiddleAssigmentApp());
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Middle Assigment - contrast shower',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContrastShowerScreenHome(),
    );
  }
}