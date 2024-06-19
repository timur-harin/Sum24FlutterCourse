import 'dart:convert';
import 'package:education/templates/middleAssignment/provider.dart';
import 'package:flutter/material.dart';
import 'preferences_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'riverpod.dart';
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
            Text("Time in shower: ${ref.watch(sessionProvider)} seconds"),
            Text("Minimal temperature: ${ref.watch(riverpod).minTemp.toString()}"),
            Text("Maximal temperature: ${ref.watch(riverpod).maxTemp.toString()}"),
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

class SessionInformarion {
  final int duration;
  final int minTemp;
  final int maxTemp;

  SessionInformarion({required this.duration, required this.minTemp, required this.maxTemp});

  Map<String, dynamic> toStart() {
    return {
      'duration': duration,
      'minTemp': minTemp,
      'maxTemp': maxTemp,
    };
  }

  factory SessionInformarion.fromStart(Map<String, dynamic> json) {
    return SessionInformarion(
      duration: json['duration'],
      minTemp: json['minTemp'],
      maxTemp: json['maxTemp'],
    );
  }

  String toJson() => json.encode(toStart());

  factory SessionInformarion.fromJson(String source) => SessionInformarion.fromStart(json.decode(source));
}
