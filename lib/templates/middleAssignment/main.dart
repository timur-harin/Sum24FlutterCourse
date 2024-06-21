import 'package:education/templates/middleAssignment/settingsScreen.dart';
import 'package:education/templates/middleAssignment/showerScreen.dart';
import 'package:education/templates/middleAssignment/summaryScreen.dart';
import 'package:flutter/material.dart';
import 'package:education/templates/middleAssignment/mainScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child:  MiddleAssigmentApp()));
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/SetUp': (context) => SettingsScreen(),
        '/ShowerScreen': (context) => ShowerScreen(),
      },
      title: 'Middle Assigment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // TODO - complete assignment

    );
  }
}