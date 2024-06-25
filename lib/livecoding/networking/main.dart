
import 'package:education/livecoding/networking/providers/provider.dart';
import 'package:education/livecoding/networking/ui/pages/finish_page.dart';
import 'package:education/livecoding/networking/ui/pages/main_page.dart';
import 'package:education/livecoding/networking/ui/pages/workout_page.dart';
import 'package:flutter/material.dart';
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
