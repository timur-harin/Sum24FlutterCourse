import 'package:education/templates/lab3/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: WaterBalanceApp()));
}

class WaterBalanceApp extends StatelessWidget {
  const WaterBalanceApp({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Balance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HydrationScreen(),
    );
  }
}
