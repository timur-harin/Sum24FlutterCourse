import 'package:education/templates/lab3/hydration.dart';
import 'package:education/templates/lab3/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: WaterBalanceApp(),
    )
  );
}

class WaterBalanceApp extends StatelessWidget {
  const WaterBalanceApp({super.key});


  @override
  Widget build(BuildContext context) {
    print(1);
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
