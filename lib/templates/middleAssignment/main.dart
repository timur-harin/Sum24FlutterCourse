import 'package:flutter/material.dart';
import 'home_page.dart';
import 'start_session_page.dart';
import 'timer_page.dart';
import 'provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MiddleAssigmentApp());
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Middle Assigment',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/startSessionPage': (context) => const StartSessionPage(),
          '/timerPage': (context) => const TimerPage(),
        },
      ),
    );
  }
}
