import 'package:education/templates/middleAssignment/homeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MiddleAssigmentApp());
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Middle Assigment',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 54, 84, 109),
      ),
      home: const HomeScreen(),
    );
  }
}