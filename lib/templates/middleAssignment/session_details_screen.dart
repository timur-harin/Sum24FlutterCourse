import 'package:flutter/material.dart';
import 'main.dart';

class SessionDetailsScreen extends StatelessWidget {
  final ShowerSession session;

  const SessionDetailsScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ...session.temperaturePhases.map((phase) => Text(
                'Phase: ${phase.temperature}, Duration: ${phase.duration} seconds')),
            Text('Comments: ${session.comments}'),
            Text('Rating: ${session.rating}'),
          ],
        ),
      ),
    );
  }
}
