import 'package:flutter/material.dart';
import 'preferences_page.dart';
import 'notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'local_storage.dart';
import 'provider.dart';

void main() {
  runApp(ProviderScope(child: MiddleAssigmentApp()));
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Middle Assigment - contrast shower',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContrastShowerScreenHome(),
    );
  }
}

class ContrastShowerScreenHome extends ConsumerWidget {
  final LocalStorageService localStorageService = LocalStorageService();
  final ProviderSession provider = ProviderSession();

  ContrastShowerScreenHome({super.key});

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
            Text("Time in shower: ${ref.watch(showerSessionProvider).elementAt(0)}"),
            Text("Minimal temperature: ${ref.watch(showerSessionProvider).elementAt(1)}"),
            Text("Maximal temperature: ${ref.watch(showerSessionProvider).elementAt(2)}"),
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