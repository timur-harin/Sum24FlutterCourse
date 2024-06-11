import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
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
              GroupButton(
                isRadio: false,
                buttons: ["12:00", "13:00", "14:30", "18:00", "19:00", "21:40"],
              )
            ],
          ),
        ),
      ),
    );
  }
}
