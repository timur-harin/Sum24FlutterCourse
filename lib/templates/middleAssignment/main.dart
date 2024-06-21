import 'package:flutter/material.dart';
import 'ui/pages/history_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() {
  runApp(const ProviderScope(child: MaterialApp(
    title: 'Middle Assigment',
    debugShowCheckedModeBanner: false,
    home:  MiddleAssigmentApp(),
  )));
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shower Counter App'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: const ShowerHistoryWidget(),
    );
  }
}