import 'active_session_screen.dart';
import 'package:flutter/material.dart';
import 'package:gradient_coloured_buttons/gradient_coloured_buttons.dart';
import 'main.dart';
import 'app_bar.dart';

class SessionOverviewScreen extends StatelessWidget {
  final ShowerSession session;

  const SessionOverviewScreen({
    super.key,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Session "${session.name}" Overview'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              itemCount: session.temperaturePhases.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListTile(
                    leading: Icon(Icons.timer,
                        color: session.temperaturePhases[index].temperature ==
                                'Hot'
                            ? Colors.red
                            : Colors.blue),
                    title: Text(
                        '${session.temperaturePhases[index].temperature} phase'),
                    subtitle: Text(
                        'Duration: ${session.temperaturePhases[index].duration} seconds'),
                  ),
                );
              },
            ),
            GradientButton(
              text: 'Begin Session',
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
