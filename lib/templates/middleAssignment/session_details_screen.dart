import 'package:flutter/material.dart';
import 'active_session_screen.dart';
import 'main.dart';
import 'app_bar.dart';
import 'package:gradient_coloured_buttons/gradient_coloured_buttons.dart';

class SessionDetailsScreen extends StatelessWidget {
  final ShowerSession session;

  const SessionDetailsScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Session "${session.name}" Details'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.timer, color: Colors.green),
              title: const Text('Total session duration'),
              subtitle: Text('${session.overallDuration} seconds'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.rate_review, color: Colors.green),
              title: const Text('Phases:'),
              subtitle: Column(
                children: session.temperaturePhases
                    .map(
                      (phase) => Card(
                        color: phase.temperature == 'Hot'
                            ? Colors.red.shade400
                            : Colors.blue.shade400,
                        elevation: 2.0,
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ListTile(
                          title: Text('${phase.temperature} phase'),
                          subtitle: Text('${phase.duration} seconds'),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.rate_review, color: Colors.green),
              title: const Text('Comments'),
              subtitle: Text(
                  session.comments == '' ? 'No comments' : session.comments),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.auto_awesome, color: Colors.green),
              title: const Text('Experience rating'),
              subtitle: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                      session.rating as int,
                      (index) => const Icon(Icons.star, color: Colors.yellow),
                    ) +
                    List.generate(
                      5 - session.rating as int,
                      (index) => Icon(Icons.star, color: Colors.grey.shade300),
                    ),
              ),
            ),
            const Divider(),
            GradientButton(
              text: 'Begin session with the same configuration',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActiveSessionScreen(
                      session: session,
                    ),
                  ),
                );
              },
              gradientColors: [Colors.green, Colors.green.shade300],
            ),
          ],
        ),
      ),
    );
  }
}
