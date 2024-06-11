import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/lab3/screen.dart'; // Импортируем MainScreen

void main() {
  runApp(
    ProviderScope(child: WaterBalanceApp()),
  );
}

class WaterBalanceApp extends StatelessWidget {
  const WaterBalanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WaterBalance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HydrationScreen(), // Устанавливаем MainScreen в качестве главного экрана
    );
  }
}
