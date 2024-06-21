import 'package:education/templates/middleAssignment/ui/pages/finish_page.dart';
import 'package:education/templates/middleAssignment/ui/pages/greet.dart';
import 'package:education/templates/middleAssignment/ui/pages/history.dart';
import 'package:education/templates/middleAssignment/ui/pages/main_page.dart';
import 'package:education/templates/middleAssignment/ui/pages/workout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
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
      title: 'Contrast Showering App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        brightness: Brightness.dark,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const GreetingPage(),
        '/main': (context) => const MainPage(),
        '/workout': (context) => const WorkoutPage(),
        '/finish': (context) => const FinishPage(),
        '/session_history': (context) => const SessionHistoryPage(),
      },
    );
  }
}
