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
            Text(
                'Total session duration: ${session.overallDuration} seconds'),
            Text('Comments: ${session.comments}'),
            Text('Rating: ${session.rating}'),
          ],
        ),
      ),
    );
  }
}
