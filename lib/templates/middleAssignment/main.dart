import 'package:flutter/material.dart';
import 'homeScreen.dart';
import 'sessionData.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(const MiddleAssignmentApp());
}

class MiddleAssignmentApp extends StatelessWidget {
  const MiddleAssignmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SessionData(),
      child: MaterialApp(
      title: 'Middle Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      )
    );
  }
}
