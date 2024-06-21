
import 'package:education/templates/middleAssignment/ui/pages/finish_page.dart';
import 'package:education/templates/middleAssignment/ui/pages/home_screen.dart';
import 'package:education/templates/middleAssignment/ui/pages/shower_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
    setPathUrlStrategy();
  runApp(ProviderScope(child: const MiddleAssigmentApp()));
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            debugShowCheckedModeBanner: false,

      title: 'Middle Assigment',
      initialRoute: "/",
      routes: {
        '/': (context) => const HomeScreen(),
        '/shower': (context) => const ShowerPage(),
        '/finish': (context) => const FinishPage(),
      },
    );
  }
}
