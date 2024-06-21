import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/middleAssignment/pages/settings.dart';
import 'package:education/templates/middleAssignment/pages/homescreen.dart';
import 'package:education/templates/middleAssignment/pages/timer.dart';
import 'package:education/templates/middleAssignment/pages/end.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>  MainScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/timer': (context) => TimerScreen(),
        '/end': (context) => EndScreen(),
      },
    );
  }
}
