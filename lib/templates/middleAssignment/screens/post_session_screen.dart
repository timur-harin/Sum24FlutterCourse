import 'package:education/templates/middleAssignment/screens/home_screen.dart';
import 'package:education/templates/middleAssignment/small_widgets/gradient_appbar.dart';
import 'package:education/templates/middleAssignment/small_widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/session_notifier.dart';

class PostSessionScreen extends ConsumerWidget {
  late int totalDuration;
  late int hotPhasesCompleted;
  late int coldPhasesCompleted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    totalDuration = arguments['totalDuration'];
    hotPhasesCompleted = arguments['hotPhasesCompleted'];
    coldPhasesCompleted = arguments['coldPhasesCompleted'];

    ref.read(sessionsProvider.notifier).updateDuration(totalDuration);
    return Scaffold(
      appBar: const GradientAppBar(
        title: 'Session Summary',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
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
                    const Text(
                      'Congratulations on completing your session!',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total Duration: ${totalDuration ~/ 60} minutes ${totalDuration % 60} seconds',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Hot Phases Completed: $hotPhasesCompleted out of ${ref.read(sessionsProvider.notifier).getCurrentSession().hotPhaseDurations.length}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Cold Phases Completed: $coldPhasesCompleted out of ${ref.read(sessionsProvider.notifier).getCurrentSession().coldPhaseDurations.length}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.cyan,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
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
                    const Text(
                      'Rate your session',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                    RatingBar.builder(
                      initialRating: 0,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return const Icon(
                              Icons.sentiment_very_dissatisfied,
                              color: Colors.red,
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
                              Icons.sentiment_very_dissatisfied,
                              color: Colors.red,
                            );
                        }
                      },
                      onRatingUpdate: (rating) {
                        ref
                            .read(sessionsProvider.notifier)
                            .updateRating(rating);
                      },
                    ),
                  ],
                ),
              ),
              GradientButton(
                buttonText: 'Back to Home',
                onPressed: () {
                  ref.read(sessionsProvider.notifier).updateHotPhasesCompleted(hotPhasesCompleted);
                  ref.read(sessionsProvider.notifier).updateColdPhasesCompleted(coldPhasesCompleted);
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
