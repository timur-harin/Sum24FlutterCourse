import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../small_widgets/gradient_button.dart';
import '../notifiers/session_notifier.dart';
import '../small_widgets/gradient_appbar.dart';

class DisplayedSessionsCount extends StateNotifier<int> {
  DisplayedSessionsCount() : super(3);

  void increment() {
    state += 3;
  }

  void reset() {
    state = 3;
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
          Transform.scale(
            scale: 1.8,
            child: Center(
              child: GradientButton(
                buttonText: 'Start New Session',
                onPressed: () {
                  ref.read(displayedSessionsCountProvider.notifier).reset();
                  Navigator.pushReplacementNamed(context, '/preferences');
                },
              ),
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
                final sortedSessions = List.from(previousSessions)
                  ..sort((a, b) => b.creationTime.compareTo(a.creationTime));

                final showerSession = sortedSessions[index];
                final date = DateFormat('dd.MM.yyyy')
                    .format(showerSession.creationTime.toLocal());
                final time = DateFormat('HH:mm')
                    .format(showerSession.creationTime.toLocal());
                return ListTile(
                  title: Text('Session on $date at $time'),
                  subtitle: Text(
                      'Duration: ${showerSession.totalDuration ~/ 60} minutes ${showerSession.totalDuration % 60} seconds'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      getIconBasedOnRating(showerSession.rating.toInt()),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                        backgroundColor:
                            getColorBasedOnRating(showerSession.rating.toInt()),
                        title: const Text(
                          'Session Details',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Date: ${DateFormat('dd.MM.yyyy').format(showerSession.creationTime.toLocal())}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Time: ${DateFormat('HH:mm').format(showerSession.creationTime.toLocal())}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Duration: ${showerSession.totalDuration ~/ 60} minutes ${showerSession.totalDuration % 60} seconds',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Hot Phases Completed: ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: Colors.red[400],
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                                '${showerSession.hotPhasesCompleted} out of ${showerSession.hotPhaseDurations.length}',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Cold Phases Completed: ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: Colors.cyan[400],
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                                '${showerSession.coldPhasesCompleted} out of ${showerSession.coldPhaseDurations.length}',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Rating: ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            getIconBasedOnRating(
                                                showerSession.rating.toInt()),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
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
    switch (rating - 1) {
      case 0:
        return const Icon(
          Icons.sentiment_very_dissatisfied,
          color: Colors.redAccent,
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

  Color getColorBasedOnRating(int rating) {
    switch (rating - 1) {
      case 0:
        return Colors.redAccent[400]!;
      case 1:
        return Colors.redAccent[400]!;
      case 2:
        return Colors.amber[400]!;
      case 3:
        return Colors.lightGreen[400]!;
      case 4:
        return Colors.green[400]!;
      default:
        return Colors.grey[400]!;
    }
  }
}
