import 'package:education/templates/middleAssignment/ShowerStoryList.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0)),
        backgroundColor: Color.fromARGB(255, 169, 239, 224),

      ),
      body: Container(
        child: const ShowerStoryList(),
      ),
    );
  }
}