import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'homescreen.dart';

void main() {
  runApp(const ProviderScope(child: MiddleAssigmentApp()));
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Middle Assignment',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF2C2C2C),

      ),
      home: const HomeScreen(),
    );
  }
}