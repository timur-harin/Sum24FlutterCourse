import 'package:education/lab_templates/lab3/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    // // TODO to enable riverpod - add ProviderScope
    const ProviderScope(child: WaterBalanceApp())
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
      // TODO to run app - change to needed screen widget
      home: const HydrationScreen(),
    );
  }
}
