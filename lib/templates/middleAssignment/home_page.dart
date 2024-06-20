import 'dart:convert';
import 'package:flutter/material.dart';
import 'preferences_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notifier.dart';

void main() {
  runApp(ProviderScope(child: MiddleAssigmentApp()));
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Middle Assigment - contrast shower',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContrastShowerScreenHome(),
    );
  }
}

class ContrastShowerScreenHome extends ConsumerWidget {
  ContrastShowerScreenHome({super.key});
  // final LocalStorage localStorage = LocalStorage();
  // final ProviderSession providerSession = ProviderSession();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(209, 68, 137, 255),
            Color.fromARGB(213, 255, 82, 82),
          ],
        ),
      ),
    child:Scaffold(
      backgroundColor: const Color.fromARGB(0, 37, 230, 244),
      appBar: AppBar(
        title: const Text('Contrast Shower Helper'),
        backgroundColor: const Color.fromARGB(255, 62, 160, 185),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to Contrast Shower Helper', style: TextStyle(fontSize: 30),),
            const Text('Previous shower session:', style: TextStyle(fontSize: 30),),
            const SizedBox(height: 15),
            Text("Time in shower: ${int.parse(ref.watch(sessionProvider).elementAt(0)) ~/ 60} minutes and ${int.parse(ref.watch(sessionProvider).elementAt(0)) % 60} seconds"),
            Text("Number of switches: ${ref.watch(sessionProvider).elementAt(1)}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Preferences()),
                );
              },
              child: const Text('Start new session'),
            )
          ],
        ),
      ),
    ),
    );
  }
}