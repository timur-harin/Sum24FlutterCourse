import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ui/pages/finish_page.dart';
import 'ui/pages/main_page.dart';
import 'ui/pages/setup_page.dart';
import 'ui/pages/take_shower_page.dart';

void main() {
  runApp(const MiddleAssigmentApp());
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Contrast Shower Companion App",
        initialRoute: "/",
        routes: {
          "/": (context) =>  MainPage(),
          "/takeShower" : (context) => TakeShowerPage(),
          "/finish" : (context) => FinishShowerPage(),
          "/setupShower": (context) => SetupPage(),
        },
      ),
    );
  }
}