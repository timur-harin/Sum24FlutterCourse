import 'package:flutter/material.dart';

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
