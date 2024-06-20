import 'package:assignment1/IntervalCircle.dart';
import 'package:assignment1/ActiveShowerSession.dart';
import 'package:flutter/material.dart';

class _NewShowerSessionState extends State<NewShowerSession> {
  double _currentSessionDuration = 20;
  double _currentIntervals = 2;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("New shower session"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ActiveShowerSession(
                        sessionLength: _currentSessionDuration * 60,
                        nIntervals: _currentIntervals.round())));
          },
          icon: Icon(Icons.play_arrow),
          label: Text("Begin session"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Padding(
          padding: EdgeInsets.only(top: 16),
          child: Column(
            children: [
              Text.rich(
                  TextSpan(children: [
                    TextSpan(children: [WidgetSpan(child: Icon(Icons.timer))]),
                    TextSpan(
                        text:
                            " Session duration: ${_currentSessionDuration} minutes"),
                  ]),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20)),
              Slider(
                  value: _currentSessionDuration,
                  max: 100,
                  min: 5,
                  divisions: 19, // TODO: replace hardcoded value
                  onChanged: (double value) {
                    setState(() {
                      _currentSessionDuration = value.roundToDouble();
                    });
                  }),
              Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        children: [WidgetSpan(child: Icon(Icons.numbers))]),
                    TextSpan(
                        text: " Number of intervals: ${_currentIntervals}"),
                  ]),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20)),
              Slider(
                  value: _currentIntervals,
                  max: 10,
                  min: 2,
                  divisions: 9,
                  onChanged: (double value) {
                    setState(() {
                      _currentIntervals = value.roundToDouble();
                    });
                  }),
              Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: IntervalCircle(
                      _currentIntervals.round(), _currentSessionDuration))
            ],
          ),
        ));
  }
}

class NewShowerSession extends StatefulWidget {
  const NewShowerSession({super.key});

  @override
  State<NewShowerSession> createState() => _NewShowerSessionState();
}
