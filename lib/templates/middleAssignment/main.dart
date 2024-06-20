import 'package:education/templates/middleAssignment/screens/main_screen.dart';
import 'package:education/templates/middleAssignment/screens/preferences_screen.dart';
import 'package:education/templates/middleAssignment/screens/session_screen.dart';
import 'package:education/templates/middleAssignment/screens/summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/session_overwiew_screen.dart';


void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contrast Shower Companion',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => const MainScreen(),
        '/overview': (context) => const SessionOverwiewScreen(),
        '/preferences': (context) => PreferencesScreen(),
        '/session': (context) => SessionScreen(),
        '/summary': (context) =>  const SummaryScreen(),
      },
    );
  }
}
