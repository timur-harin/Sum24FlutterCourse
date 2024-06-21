import 'package:flutter/material.dart';
import 'theme.dart';

class SummaryScreen extends StatelessWidget {
  final DateTime date;
  final int totalMinutes;
  final int hotDuration;
  final int coldDuration;
  final int hotTemperature;
  final int coldTemperature;
  final int cycles;

  SummaryScreen({
    required this.date,
    required this.totalMinutes,
    required this.hotDuration,
    required this.coldDuration,
    required this.hotTemperature,
    required this.coldTemperature,
    required this.cycles,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Session Summary',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${date.day}-${date.month}-${date.year}', style: Theme.of(context).textTheme.bodyLarge),
            Text('Total Duration: $totalMinutes minutes', style: Theme.of(context).textTheme.bodyLarge),
            Text('Hot Duration: $hotDuration seconds', style: Theme.of(context).textTheme.bodyLarge),
            Text('Cold Duration: $coldDuration seconds', style: Theme.of(context).textTheme.bodyLarge),
            Text('Hot Temperature: $hotTemperature°C', style: Theme.of(context).textTheme.bodyLarge),
            Text('Cold Temperature: $coldTemperature°C', style: Theme.of(context).textTheme.bodyLarge),
            Text('Number of Cycles: $cycles', style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
