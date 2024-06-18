import 'screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MiddleAssigmentApp()));
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Middle Assigment',
      theme: ThemeData(
        canvasColor: Colors.white,
        textTheme: TextTheme(
          titleLarge: TextStyle(color: Colors.blue[900]),
          bodyLarge: TextStyle(color: Colors.blue[700]),
          bodyMedium: TextStyle(color: Colors.blue[500]),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(Colors.white),
            textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 20)),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
