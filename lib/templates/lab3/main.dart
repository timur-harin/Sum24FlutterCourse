import 'screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(child: WaterBalanceApp()),
  );
}

class WaterBalanceApp extends StatelessWidget {
  const WaterBalanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WaterBalance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HydrationScreen(),
    );
  }
}
