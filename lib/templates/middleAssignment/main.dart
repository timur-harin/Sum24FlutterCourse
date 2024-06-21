import 'package:education/templates/middleAssignment/screens/finish_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';
import 'screens/session_screen.dart';
import 'services/storage_manager.dart';
import 'models/shower_session.dart';


void main() {
  runApp(ProviderScope( 
      child: MiddleAssigmentApp(), 
    ),);
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
      initialRoute: "/",
      routes: {
        '/': (context) => HomeScreen(),
        '/shower': (context) => SessionScreen(),
        '/finish_session': (context) => const FinishSession(),
      }, 
    );
  }
 }
