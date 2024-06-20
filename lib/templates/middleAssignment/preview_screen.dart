import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'active_session_screen.dart';
import 'shower_session.dart';
import 'theme.dart';

class PreviewSessionDialog extends StatelessWidget {
  final int totalDuration;
  final int hotDuration;
  final int coldDuration;
  final int hotTemperature;
  final int coldTemperature;

  PreviewSessionDialog({
    required this.totalDuration,
    required this.hotDuration,
    required this.coldDuration,
    required this.hotTemperature,
    required this.coldTemperature,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Preview Session'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Total Duration: $totalDuration minutes'),
          Text('Hot Duration: $hotDuration seconds'),
          Text('Cold Duration: $coldDuration seconds'),
          Text('Hot Temperature: $hotTemperature °C'),
          Text('Cold Temperature: $coldTemperature °C'),
          Text('Number of Cycles: ${totalDuration * 60 ~/ (hotDuration + coldDuration)}'),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final newSession = ShowerSession(
              date: DateTime.now(),
              totalDuration: totalDuration,
              hotDuration: hotDuration,
              coldDuration: coldDuration,
              hotTemperature: hotTemperature,
              coldTemperature: coldTemperature,
              cycles: List.generate(
                totalDuration * 60 ~/ (hotDuration + coldDuration),
                    (index) => ShowerCycle(
                  hotDuration: hotDuration,
                  coldDuration: coldDuration,
                ),
              ),
            );

            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ActiveSessionScreen(
                  session: newSession,
                  currentCycle: 0,
                  isHot: true,
                ),
              ),
            );
          },
          child: Text('Start Session'),
        ),
      ],
    );
  }
}
