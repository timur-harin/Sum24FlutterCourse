import 'package:education/templates/middleAssignment/Pages/homePage.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        //'/workout': (context) => WorkoutPage(),
        //'/finish': (context) => FinishPage(),
      },

    );
  }
  
}
