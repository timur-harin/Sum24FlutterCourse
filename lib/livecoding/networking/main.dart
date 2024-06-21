import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/provider.dart';
import 'ui/pages/finish_page.dart';
import 'ui/pages/main_page.dart';
import 'ui/pages/workout_page.dart';

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
        '/': (context) => const MainPage(),
        '/workout': (context) => const WorkoutPage(),
        '/finish': (context) => const FinishPage(),
      },
    );
  }
}
