import 'package:education/templates/middleAssignment/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        primaryColor: const Color(0xFF24305E),
        scaffoldBackgroundColor: Color.fromARGB(255, 235, 245, 250),
        textTheme: GoogleFonts.kanitTextTheme(),
      ),
      home: const HomeScreen(),
    );
  }
}