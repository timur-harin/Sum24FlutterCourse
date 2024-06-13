import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'preferences.dart';

class ContrastShowerScreenHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(209, 68, 137, 255),
            
            Color.fromARGB(106, 155, 39, 176),
            
            Color.fromARGB(213, 255, 82, 82),
          ],
        ),
      ),
    child:Scaffold(
      backgroundColor: const Color.fromARGB(0, 37, 230, 244),
      appBar: AppBar(
        title: const Text('Contrast Shower Helper'),
        backgroundColor: Color.fromARGB(255, 62, 160, 185),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Previous shower sessions'),
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