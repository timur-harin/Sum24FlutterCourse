import 'package:flutter/material.dart';
import 'package:education/templates/middleAssignment/mainScreen.dart';

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
        primarySwatch: Colors.blue,
      ),
      // TODO - complete assignment
      home: MainScreen(),
    );
  }
}