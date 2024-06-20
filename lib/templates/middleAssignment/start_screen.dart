import 'package:education/templates/middleAssignment/riverpod_history.dart';
import 'package:education/templates/middleAssignment/widgets_templates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'session_screen.dart';

/// Widget representing the start menu of the app.
class StartMenu extends ConsumerWidget {
  const StartMenu({super.key});

  /// Shows the bottom sheet for setting session length.
  ///
  /// @param context The build context.
  /// @param ref The widget reference.
  void _showSessionLengthBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return _buildSessionSettingsSheet(context, ref);
      },
    );
  }

  /// Sets the content for the bottom sheet.
  ///
  /// @param context The build context.
  /// @param ref The widget reference.
  Widget _buildSessionSettingsSheet(BuildContext context, WidgetRef ref) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Templates.buildSlider(
                  context: context,
                  title: 'Cold Phase Duration (min)',
                  param: ref.read(coldPhaseTimerProvider.notifier).state,
                  min: 1.0,
                  max: 10.0,
                  onChanged: (value) {
                    setState(() {
                      ref.read(coldPhaseTimerProvider.notifier).state = value;
                    });
                  }),
              Templates.buildSlider(
                  context: context,
                  title: 'Hot Phase Duration (min)',
                  param: ref.read(hotPhaseTimerProvider.notifier).state,
                  min: 1.0,
                  max: 10.0,
                  onChanged: (value) {
                    setState(() {
                      ref.read(hotPhaseTimerProvider.notifier).state = value;
                    });
                  }),
              Templates.buildSlider(
                  bottomPadding: 10,
                  context: context,
                  title: 'Total Number of Phases',
                  param: ref.read(numberOfPhasesProvider.notifier).state,
                  min: 2.0,
                  max: 8.0,
                  onChanged: (value) {
                    setState(
                      () {
                        ref.read(numberOfPhasesProvider.notifier).state = value;
                      },
                    );
                  }),
              Text(
                'First Phase',
                style: TextStyle(
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.w900,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Templates.buildButton(
                      context: context,
                      ref: ref,
                      onPressed: () {
                        ref.read(backgroundColorProvider.notifier).state =
                            Colors.blue;
                      },
                      width: 110,
                      height: 50,
                      text: const Text('Cold',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                              color: Colors.white))),
                  const SizedBox(
                    width: 10,
                  ),
                  Templates.buildButton(
                      context: context,
                      ref: ref,
                      onPressed: () {
                        ref.read(backgroundColorProvider.notifier).state =
                            Colors.orange;
                      },
                      width: 110,
                      height: 50,
                      color: Colors.orange,
                      text: const Text('Hot',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                              color: Colors.white))),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Templates.buildButton(
                  context: context,
                  ref: ref,
                  onPressed: () {
                    _setUpSession(context, ref);
                  },
                  width: 230,
                  height: 55,
                  text: const Text('Session Details',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Colors.white))),
            ],
          ),
        );
      },
    );
  }

  /// Sets up the session based on user input.
  ///
  /// @param context The build context.
  /// @param ref The widget reference.
  void _setUpSession(BuildContext context, WidgetRef ref) {
    Navigator.pop(context);
    ref.read(timerProvider.notifier).state = _calculateTotalDuration(ref) * 60;
    _sessionOverview(context, ref);
  }

  /// Begins the session.
  ///
  /// @param context The build context.
  void _beginSession(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ShowerSession()),
    );
  }

  /// Shows an overview of the session settings in an alert dialog.
  ///
  /// @param context The build context.
  /// @param ref The widget reference.
  void _sessionOverview(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Session Details',
              style: TextStyle(color: Colors.blue)),
          content: Templates.buildDialogContent(ref: ref, children: <Widget>[
            Text(
                'Total Session Duration: ${formatTime(ref.watch(timerProvider))}'),
            Text('Cold Phases Duration: ${ref.watch(coldPhaseTimerProvider)}'),
            Text('Hot Phases Duration: ${ref.watch(hotPhaseTimerProvider)}'),
            Text(
                'First Phase: ${(ref.watch(backgroundColorProvider) == Colors.blue) ? 'Cold' : 'Hot'}'),
          ]),
          actions: <Widget>[
            Templates.buildButton(
                context: context,
                ref: ref,
                onPressed: () {
                  _beginSession(context);
                },
                width: 140,
                height: 40,
                text: const Text('Begin Session',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                        color: Colors.white)),
                radius: 7),
          ],
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    );
  }

  /// Calculates the total duration of the session based on user input.
  ///
  /// @param ref The widget reference.
  /// @return The total duration of the session.
  double _calculateTotalDuration(WidgetRef ref) {
    switch (ref.watch(backgroundColorProvider)) {
      case (Colors.blue):
        return ref.read(coldPhaseTimerProvider.notifier).state *
            (ref.read(numberOfPhasesProvider.notifier).state / 2).ceil() +
            ref.read(hotPhaseTimerProvider.notifier).state *
                (ref.read(numberOfPhasesProvider.notifier).state / 2).floor();
      case (Colors.orange):
        return ref.read(coldPhaseTimerProvider.notifier).state *
            (ref.read(numberOfPhasesProvider.notifier).state / 2).floor() +
            ref.read(hotPhaseTimerProvider.notifier).state *
                (ref.read(numberOfPhasesProvider.notifier).state / 2).ceil();
      default:
        return 0;
    }
  }

  /// Formats the history data for display in the UI.
  ///
  /// @param context The build context.
  /// @param history The list of session history.
  /// @return A list of formatted widgets for display.
  List<Widget> getHistoryFormatted(BuildContext context, List<String> history) {
    final newFormat = history.reversed.take(4).map((sessionInfo) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 100,
        width: double.infinity,
        color: Colors.blue.withOpacity(0.7),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.185),
            child: Text(
              parseSessionInfo(sessionInfo),
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                  color: Colors.white),
            ),
          ),
        ),
      );
    }).toList();

    return newFormat.toList();
  }

  /// Parses the session information for display in the UI.
  ///
  /// @param sessionInfo The session information string.
  /// @return The parsed session information string.
  String parseSessionInfo(String sessionInfo) {
    String duration = sessionInfo.substring(
        sessionInfo.indexOf('<duration>') + '<duration>'.length,
        sessionInfo.indexOf('</duration>'));

    String phaseNumber = sessionInfo.substring(
        sessionInfo.indexOf('<phaseNumber>') + '<phaseNumber>'.length,
        sessionInfo.indexOf('</phaseNumber>'));

    String rating = sessionInfo.substring(
        sessionInfo.indexOf('<rating>') + '<rating>'.length,
        sessionInfo.indexOf('</rating>'));

    return 'Duration: $duration min\n'
        'Completed Phases: $phaseNumber\n'
        'Rating: $rating';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyProvider);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: history.isEmpty
                  ? Text(
                      'Click the Button Below',
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: getHistoryFormatted(context, history),
                    ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Templates.buildButton(
                      context: context,
                      ref: ref,
                      onPressed: () {
                        _showSessionLengthBottomSheet(context, ref);
                      },
                      width: 250,
                      height: 64,
                      text: const Text(
                        'Set Up the Session',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24.0,
                            color: Colors.white),
                      ))))
        ],
      ),
    );
  }
}
