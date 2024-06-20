import 'package:flutter/material.dart';

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
        title: Text('Session Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${date.day} ${_monthName(date.month)} ${date.year}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Total Duration: $totalMinutes minutes', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Hot Duration: $hotDuration seconds', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Cold Duration: $coldDuration seconds', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Hot Temperature: $hotTemperature°C', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Cold Temperature: $coldTemperature°C', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Cycles: $cycles', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  String _monthName(int month) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return monthNames[month - 1];
  }
}
