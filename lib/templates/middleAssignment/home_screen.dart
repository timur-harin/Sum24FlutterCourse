import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'session_screen.dart';
import 'summary_screen.dart';
import 'shower_session.dart';
import 'session_history_provider.dart';
import 'theme.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionHistory = ref.watch(sessionHistoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Contrast Shower Companion', style: Theme.of(context).textTheme.headlineLarge)),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SessionScreen()),
                );
              },
              child: Text('New Session'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: sessionHistory.isEmpty
                  ? Center(child: Text('No sessions yet.'))
                  : ListView.builder(
                itemCount: sessionHistory.length,
                itemBuilder: (context, index) {
                  final session = sessionHistory[index];
                  final cardColor = index % 2 == 0
                      ? AppColors.cardBackground
                      : AppColors.cardAlternative;
                  return Card(
                    color: cardColor,
                    child: ListTile(
                      title: Text(
                          '${session.date.day} ${_monthName(session.date.month)} ${session.date.year}'),
                      subtitle: Text(
                          'Total Duration: ${session.totalDuration} minutes'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SummaryScreen(
                              date: session.date,
                              totalMinutes: session.totalDuration,
                              hotDuration: session.hotDuration,
                              coldDuration: session.coldDuration,
                              hotTemperature: session.hotTemperature,
                              coldTemperature: session.coldTemperature,
                              cycles: session.cycles.length,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.accent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '© 2024 Contrast Shower Companion',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  String _monthName(int month) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[month - 1];
  }
}
