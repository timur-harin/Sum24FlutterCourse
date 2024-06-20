import 'package:flutter/material.dart';
import 'session_history.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<SessionHistory> sessionHistory = [
  SessionHistory(id: 1, duration: 10),
  SessionHistory(id: 2, duration: 15),
  SessionHistory(id: 3, duration: 12),
];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contrast Shower Companion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Shower Session History',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              itemCount: sessionHistory.length,
              itemBuilder: (context, index) {
                final session = sessionHistory[index];
                return ListTile(
                  title: Text('Session ${index + 1}'),
                  subtitle: Text('Duration: ${session.duration} minutes'),
                );
              },
            ),
            // Add code to display the user's shower session history here
            // You can use a ListView.builder to dynamically display the sessions
            ElevatedButton(
              onPressed: () {
                // Add code to navigate to the session preferences screen here
              },
              child: const Text('Start New Session'),
            ),
          ],
        ),
      ),
    );
  }
}