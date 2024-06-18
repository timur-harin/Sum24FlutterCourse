import 'package:education/templates/middleAssignment/providers/provider.dart';
import 'package:education/templates/middleAssignment/ui/pages/finish_page.dart';
import 'package:education/templates/middleAssignment/ui/pages/home_screen.dart';
import 'package:education/templates/middleAssignment/ui/pages/shower_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ShowerProvider())],
    child: MiddleAssigmentApp(),
  );
  runApp(const MiddleAssigmentApp());
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Middle Assigment',
      initialRoute: "/",
      routes: {
        '/': (context) => const HomeScreen(),
        '/shower': (context) => const ShowerPage(),
        '/finish': (context) => const FinishPage(),
      },
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      // // TODO - complete assignment
      // home: null,
    );
  }
}
