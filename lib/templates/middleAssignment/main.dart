import 'package:education/templates/middleAssignment/data/boxes.dart';
import 'package:education/templates/middleAssignment/screens/home.dart';
import 'package:education/templates/middleAssignment/screens/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  // TODO is it effective to await for boxes before running the app?
  await Hive.initFlutter();
  await Boxes.openBoxes();
  runApp(const ProviderScope(child: MiddleAssigmentApp()));
}

class MiddleAssigmentApp extends StatefulWidget {
  const MiddleAssigmentApp({super.key});

  @override
  State<StatefulWidget> createState() => _MiddleAssignmentAppState();
}

class _MiddleAssignmentAppState extends State<MiddleAssigmentApp> {
  @override
  Widget build(BuildContext context) {
    // TODO - complete assignment
    return MaterialApp(
      title: 'Middle Assigment',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/': (context) => const HomeScreen(),
        '/session': (context) => const ShowerSessionScreen(),
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
