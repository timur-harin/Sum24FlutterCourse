import 'package:flutter/material.dart';

class GreetingPage extends StatelessWidget {
  const GreetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/main');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink,
          ),
          child: const Text('Enter', style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
