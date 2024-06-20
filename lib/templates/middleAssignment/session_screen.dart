import 'dart:async';

import 'package:education/templates/middleAssignment/rating_widget.dart';
import 'package:education/templates/middleAssignment/riverpod_history.dart';
import 'package:education/templates/middleAssignment/widgets_templates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// State provider for the session timer.
final timerProvider = StateProvider<double>((ref) => 2);

/// State provider for the cold phase timer.
final coldPhaseTimerProvider = StateProvider<double>((ref) => 1);

/// State provider for the hot phase timer.
final hotPhaseTimerProvider = StateProvider<double>((ref) => 1);

/// State provider for the number of phases.
final numberOfPhasesProvider = StateProvider<double>((ref) => 2);

/// State provider for the background color.
final backgroundColorProvider = StateProvider<Color>((ref) => Colors.blue);

/// State provider for the session rating.
final ratingProvider = StateProvider<int>((ref) => 0);

/// State provider for tracking if the timer is running.
final isTimerRunningProvider = StateProvider<bool>((ref) => false);

/// Widget for managing the shower session.
class ShowerSession extends ConsumerWidget {
  late Timer _timer;
  double? _sessionDuration;
  bool _isStarted = false;
  double _phaseTimer = 0;
  int _completedPhases = 0;

  ShowerSession({super.key});

  /// Toggles the timer for the shower session.
  ///
  /// @param context The build context.
  /// @param ref The widget reference.
  void _toggleTimer(BuildContext context, WidgetRef ref) {
    if (!_isStarted) {
      _sessionDuration = ref.watch(timerProvider);
      _isStarted = true;
    }

    if (ref.watch(isTimerRunningProvider)) {
      ref.read(isTimerRunningProvider.notifier).state = false;
      _timer.cancel();
    } else {
      ref.read(isTimerRunningProvider.notifier).state = true;
      _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        if (ref.watch(timerProvider) > 0) {
          ref.read(timerProvider.notifier).state -= 0.01;
          _phaseTimer -= 10;
          if (_phaseTimer == 0) {
            if (ref.watch(backgroundColorProvider) == Colors.blue) {
              _phaseTimer = ref.watch(hotPhaseTimerProvider) * 60 * 1000;
            } else {
              _phaseTimer = ref.watch(coldPhaseTimerProvider) * 60 * 1000;
            }
            _changeBackground(ref);
            _completedPhases++;
          }
        } else {
          _timer.cancel();
          _sessionStats(context, ref);
        }
      });
    }
  }

  /// Changes the background color based on the current phase.
  ///
  /// @param ref The widget reference.
  void _changeBackground(WidgetRef ref) {
    if (ref.watch(backgroundColorProvider) == Colors.blue) {
      ref.read(backgroundColorProvider.notifier).state = Colors.orange;
    } else {
      ref.read(backgroundColorProvider.notifier).state = Colors.blue;
    }
  }

  /// Ends the shower session and displays session statistics.
  ///
  /// @param context The build context.
  /// @param ref The widget reference.
  void _endSession(BuildContext context, WidgetRef ref) {
    _timer.cancel();
    _sessionStats(context, ref);
    ref.read(isTimerRunningProvider.notifier).state = false;
  }

  /// Displays the session statistics in an alert dialog.
  ///
  /// @param context The build context.
  /// @param ref The widget reference.
  void _sessionStats(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Session Statistics',
              style: TextStyle(color: Colors.blue)),
          content: _buildDialogContent(ref),
          actions: <Widget>[
            Templates.buildButton(
                context: context,
                ref: ref,
                onPressed: () {
                  returnToStartMenu(context, ref);
                },
                width: 140,
                height: 40,
                text: const Text('Finish Session',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                        color: Colors.white)),
                radius: 7),
          ],
        );
      },
    );
  }

  /// Builds the content for the session statistics dialog.
  ///
  /// @param ref The widget reference.
  /// @return The constructed content widget.
  Widget _buildDialogContent(WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            'Session Duration: ${formatTime(_sessionDuration! - ref.watch(timerProvider))} seconds'),
        Text('Completed Phases: $_completedPhases'),
        const SizedBox(
          height: 5,
        ),
        StarRatingWidget(
          ref: ref,
        ),
      ],
    );
  }

  /// Handles the return to the start menu after finishing the session.
  ///
  /// @param context The build context.
  /// @param ref The widget reference.
  void returnToStartMenu(BuildContext context, WidgetRef ref) {
    String rating = ref.read(ratingProvider.notifier).state.toString();
    rating = (rating == '0') ? 'No Rating Provided' : '$rating/5';
    ref.read(historyProvider.notifier).addSession(
        '<duration>${formatTime(_sessionDuration! - ref.watch(timerProvider))}</duration>'
        '<phaseNumber>$_completedPhases</phaseNumber>'
        '<rating>$rating</rating>');
    ref.read(ratingProvider.notifier).state = 0;
    ref.read(backgroundColorProvider.notifier).state = Colors.blue;
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!_isStarted) {
      switch (ref.read(backgroundColorProvider)) {
        case (Colors.blue):
          _phaseTimer = ref.watch(coldPhaseTimerProvider) * 60 * 1000;
          break;
        case (Colors.orange):
          _phaseTimer = ref.watch(hotPhaseTimerProvider) * 60 * 1000;
          break;
      }
    }
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: ref.watch(backgroundColorProvider).withOpacity(0.7),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 500),
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w900,
                    color: ref.watch(backgroundColorProvider),
                  ),
                  child: Text(ref.watch(backgroundColorProvider) == Colors.blue
                      ? 'Cold Phase'
                      : 'Hot Phase')),
              Text(
                formatTime(ref.watch(timerProvider)),
                style: const TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 500),
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w900,
                    color: ref.watch(backgroundColorProvider),
                  ),
                  child: Text(formatTimeWithMilliseconds(_phaseTimer))),
              const SizedBox(
                height: 5,
              ),
              Templates.buildButton(
                  context: context,
                  ref: ref,
                  onPressed: () {
                    _toggleTimer(context, ref);
                  },
                  width: 200,
                  height: 70,
                  text: Text(
                      ref.watch(isTimerRunningProvider) ? 'Pause' : 'Start',
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 28.0,
                          color: Colors.white)),
                  color: ref.watch(backgroundColorProvider)),
              const SizedBox(height: 10),
              Templates.buildButton(
                  context: context,
                  ref: ref,
                  onPressed: () {
                    _endSession(context, ref);
                  },
                  width: 200,
                  height: 70,
                  text: const Text(
                    'Stop',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 28.0,
                        color: Colors.white),
                  ),
                  color: ref.watch(backgroundColorProvider)),
            ],
          ),
        ),
      ),
    );
  }
}

/// Formats the time in minutes and seconds.
///
/// @param seconds The time in seconds.
/// @return The formatted time string.
String formatTime(double seconds) {
  if (seconds < 0) {
    seconds = 0;
  }

  int minutes = (seconds ~/ 60) % 60;
  int remainingSeconds = (seconds % 60).toInt();
  return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
}

/// Formats the time in minutes, seconds, and milliseconds.
///
/// @param milliseconds The time in milliseconds.
/// @return The formatted time string.
String formatTimeWithMilliseconds(double milliseconds) {
  if (milliseconds < 0) {
    milliseconds = 0;
  }

  int seconds = (milliseconds / 1000).floor();
  int minutes = (seconds ~/ 60) % 60;
  int remainingSeconds = seconds % 60;
  int remainingMilliseconds = (milliseconds % 1000).toInt();

  String millisecondsString = remainingMilliseconds.toString().padLeft(3, '0');
  millisecondsString = millisecondsString.substring(0, 2);

  return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}.$millisecondsString';
}
