import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'finish_page.dart';
import 'main_page.dart';
import 'provider.dart';
import 'workout_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => WorkoutProvider())],
      child: const ExampleApp(),
    ),
  );
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Workout App',
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/workout': (context) => WorkoutPage(),
        '/finish': (context) => FinishPage(),
      },
    );
  }
}
