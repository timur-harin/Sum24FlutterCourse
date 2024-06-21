import 'package:flutter/material.dart';
import 'package:shower_companion/screens/main_screen.dart';

class AfterSessionScreen extends StatelessWidget {
  const AfterSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text('Good job!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your session has ended!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),

            
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                );
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
