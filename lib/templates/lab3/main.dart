import 'package:flutter/material.dart';

void main() {
  runApp(
    // TODO to enable riverpod - add ProviderScope
    const WaterBalanceApp(),
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
      home: null,
    );
  }
}
