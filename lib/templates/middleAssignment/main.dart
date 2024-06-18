import 'package:education/templates/middleAssignment/SessionOverview.dart';
import 'package:education/templates/middleAssignment/ShowerProcess.dart';
import 'package:flutter/material.dart';
import 'package:education/templates/middleAssignment/ShowerScreen.dart';
import 'package:education/templates/middleAssignment/newShower.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() {
  runApp(const ProviderScope(child: MiddleAssigmentApp()));
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Middle Assigment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // TODO - complete assignment

      initialRoute: '/',
      routes: {
        '/' : (context) => Showerscreen(),
        '/new' : (context) => Newshower(),
        '/new/SessionOverview' : (context) => Sessionoverview(),
        '/new/SessionOverview/shoverProcess' : (context) => Showerprocess(),
      },
    );
  }
}