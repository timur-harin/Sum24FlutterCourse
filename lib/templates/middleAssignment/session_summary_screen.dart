import 'star_rating.dart';
import 'package:flutter/material.dart';
import 'package:gradient_coloured_buttons/gradient_coloured_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class SessionSummaryScreen extends StatefulWidget {
  final ShowerSession session;

  const SessionSummaryScreen({
    super.key,
    required this.session,
  });

  @override
  _SessionSummaryScreenState createState() => _SessionSummaryScreenState();
}

class _SessionSummaryScreenState extends State<SessionSummaryScreen> {
  String comments = '';
  double rating = 0.0; // Add this line to hold the current rating

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Session ${widget.session.name} Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ...widget.session.temperaturePhases.map((phase) => Text(
                'Phase: ${phase.temperature}, Duration: ${phase.duration} seconds')),
            TextField(
              onChanged: (value) {
                setState(() {
                  comments = value;
                });
              },
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Comments',
              ),
            ),
            const Padding(padding: EdgeInsets.all(2.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text('Rate this session: '),
                StarRating(
                  rating: rating,
                  // Use the rating variable here
                  onRatingChanged: (newRating) =>
                      setState(() => rating = newRating),
                  // Update the rating variable when the rating changes
                  color: Colors.yellow,
                ),
              ],
            ),
            GradientButton(
              text: 'Save Session',
              onPressed: () async {
                final newSession = ShowerSession(
                  name: widget.session.name,
                  comments: comments,
                  temperaturePhases: widget.session.temperaturePhases,
                  rating: rating,
                );
                SharedPreferences prefs = await SharedPreferences.getInstance();
                List<String> sessionStrings =
                    prefs.getStringList('sessions') ?? [];
                sessionStrings.add(newSession.toJson());
                await prefs.setStringList('sessions', sessionStrings);
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              gradientColors: [Colors.green, Colors.green.shade300],
            ),
          ],
        ),
      ),
    );
  }
}
