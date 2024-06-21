// active_shower_screen.dart
import 'package:flutter/material.dart';
import 'shower_history_repository.dart'; // Import the ShowerHistorySession
class ActiveShowerScreen extends StatelessWidget {
  final ShowerHistorySession session;

  ActiveShowerScreen({Key? key, required this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shower Session Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Date: ${session.date}'),
            Text('Duration: ${session.duration.inMinutes} minutes'),
          ],
        ),
      ),
    );
  }
}