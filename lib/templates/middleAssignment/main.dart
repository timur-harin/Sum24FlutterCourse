import 'package:education/templates/middleAssignment/homePage.dart';
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
        primarySwatch: Colors.orange,
      ),
      // TODO - complete assignment
      home: const HomePage(),

    );
  }
  
}
