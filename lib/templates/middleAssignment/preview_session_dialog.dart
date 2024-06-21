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
    final int cycles = totalDuration * 60 ~/ (hotDuration + coldDuration);

    return AlertDialog(
      title: Text('Preview Session'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total Duration: $totalDuration minutes'),
          Text('Hot Duration: $hotDuration seconds'),
          Text('Cold Duration: $coldDuration seconds'),
          Text('Hot Temperature: $hotTemperature°C'),
          Text('Cold Temperature: $coldTemperature°C'),
          Text('Number of Cycles: $cycles'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Close'),
        ),
      ],
    );
  }
}
