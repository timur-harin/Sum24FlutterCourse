import 'package:flutter/material.dart';
import 'providers/provider.dart';
import 'pages/finish_page.dart';
import 'pages/main_page.dart';
import 'pages/workout_page.dart';
import 'package:provider/provider.dart';

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
      title: 'Contrast Shower',
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/workout': (context) => WorkoutPage(),
        '/finish': (context) => FinishPage(),
      },
    );
  }
}
