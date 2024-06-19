import 'package:education/templates/middleAssignment/shared_preferences_service.dart';

import 'star_rating.dart';
import 'package:flutter/material.dart';
import 'package:gradient_coloured_buttons/gradient_coloured_buttons.dart';

import 'main.dart';
import 'package:provider/provider.dart' as provider;
import 'theme.dart';
import 'app_bar.dart';

class SessionSummaryScreen extends StatefulWidget {
  final ShowerSession session;
  final int timeSpent;

  const SessionSummaryScreen({
    super.key,
    required this.session,
    required this.timeSpent,
  });

  @override
  _SessionSummaryScreenState createState() => _SessionSummaryScreenState();

  get _timeSpent => timeSpent;
}

class _SessionSummaryScreenState extends State<SessionSummaryScreen> {
  String comments = '';
  double rating = 0.0;
  int timeSpent = 0;
  final prefs = SharedPreferencesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Session "${widget.session.name}" Summary'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text('Session duration: ${widget.timeSpent} seconds'),
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
                  onRatingChanged: (newRating) =>
                      setState(() => rating = newRating),
                  color: Colors.yellow,
                ),
              ],
            ),
            GradientButton(
              text: 'Save Session',
              onPressed: () async {
                ShowerSession newSession = ShowerSession(
                  name: widget.session.name,
                  comments: comments,
                  temperaturePhases: widget.session.temperaturePhases,
                  rating: rating,
                  overallDuration: widget.timeSpent,
                );
                List<String> sessionStrings =
                    await prefs.getStringList('sessions') ?? [];
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
