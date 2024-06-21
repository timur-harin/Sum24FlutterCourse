import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'homePage.dart';
import 'settingspage.dart';
import 'shower.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MiddleAssigmentApp(),
    ),
  );
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Middle Assigment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // TODO - complete assignment
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/settings': (context) => const SettingsPage(),
        '/shower': (context) => const ShowerPage(),
      },
    );
  }
}
