import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../small_widgets/gradient_button.dart';
import 'preferences_screen.dart';
import '../notifiers/session_notifier.dart';
import '../small_widgets/gradient_appbar.dart';

class DisplayedSessionsCount extends StateNotifier<int> {
  DisplayedSessionsCount() : super(3);

  void increment() {
    state += 3;
  }
}

final displayedSessionsCountProvider =
    StateNotifierProvider<DisplayedSessionsCount, int>(
        (ref) => DisplayedSessionsCount());

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final previousSessions = ref.watch(sessionsProvider);
    final displayedSessionsCount = ref.watch(displayedSessionsCountProvider);

    return Scaffold(
      appBar: const GradientAppBar(
        title: 'Contrast Shower Companion',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 120),
          Center(
            child: GradientButton(
              buttonText: 'Start New Session',
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const PreferencesScreen(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 80),
          const Text(
            'Previous Sessions',
            style: TextStyle(
              fontSize: 20,
              decoration: TextDecoration.underline,
              decorationColor: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: min(displayedSessionsCount, previousSessions.length),
              itemBuilder: (context, index) {
                final session = previousSessions[
                    min(displayedSessionsCount, previousSessions.length) -
                        1 -
                        index];
                final date = DateFormat('dd.MM.yyyy')
                    .format(session.creationTime.toLocal());
                final time =
                    DateFormat('HH:mm').format(session.creationTime.toLocal());
                return ListTile(
                  title: Text('Session on $date at $time'),
                  subtitle: Text(
                      'Duration: ${session.totalDuration ~/ 60} minutes ${session.totalDuration % 60} seconds'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      getIconBasedOnRating(session.rating.toInt()),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  onTap: () {
                    // Navigate to session details screen
                  },
                );
              },
            ),
          ),
          if (displayedSessionsCount < previousSessions.length)
            GradientButton(
              buttonText: 'Show more sessions',
              onPressed: () {
                ref.read(displayedSessionsCountProvider.notifier).increment();
              },
            ),
        ],
      ),
    );
  }

  Icon getIconBasedOnRating(int rating) {
  switch (rating) {
    case 0:
      return const Icon(
        Icons.sentiment_neutral,
        color: Colors.grey,
      );
    case 1:
      return const Icon(
        Icons.sentiment_dissatisfied,
        color: Colors.redAccent,
      );
    case 2:
      return const Icon(
        Icons.sentiment_neutral,
        color: Colors.amber,
      );
    case 3:
      return const Icon(
        Icons.sentiment_satisfied,
        color: Colors.lightGreen,
      );
    case 4:
      return const Icon(
        Icons.sentiment_very_satisfied,
        color: Colors.green,
      );
    default:
      return const Icon(
        Icons.sentiment_neutral,
        color: Colors.grey,
      );
  }
}
}
