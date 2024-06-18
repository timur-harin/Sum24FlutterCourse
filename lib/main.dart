import 'package:flutter/material.dart';

import 'package:education/templates/lab4/main.dart';

void main() {
  runApp(MyApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text('Hello World!'),
            ],
          ),
        ),
      ),
    );
  }
}
