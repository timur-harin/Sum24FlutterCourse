import 'dart:async';

import 'package:education/templates/middleAssignment/ui/summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:provider/provider.dart';

import '../custom_render_object.dart';
import '../data/providers/session_provider.dart';



class ActiveSessionScreen extends StatefulWidget {
  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> {
  Timer? _timer;
  int _sessionPhase = 0;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      if (!_isPaused) {
        context.read<SessionProvider>().updateRemainingTime();
        if (_sessionPhase == 0) {
          _sessionPhase = 1;
        } else {
          _sessionPhase = 0;
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionProvider>().currentSession;

    if (session == null) {
      // Handle the case where the session is null, e.g. by navigating back to the home screen
      return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Back to Home'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Active Session'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TemperaturePhaseIndicator(temperature: session.phases[_sessionPhase].temperature),
            SizedBox(height: 20),
          
            Stack(
              alignment: Alignment.center,
              children: [

                Container(
                  width: 120, // adjust the size as needed
                  height: 120, // adjust the size as needed
                  child: CircularProgressIndicator(
                    value: (session.duration - session.remainingTime!) / session.duration,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(Colors.red),
                  ),
                ),
                Center(
                  child: Text(
                    '${session.remainingTime} min',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isPaused =!_isPaused;
                });
                if (_isPaused) {
                  _timer?.cancel();
                } else {
                  _timer = Timer.periodic(Duration(minutes: 1), (timer) {
                    context.read<SessionProvider>().updateRemainingTime();
                    if (_sessionPhase == 0) {
                      _sessionPhase = 1;
                    } else {
                      _sessionPhase = 0;
                    }
                  });
                }
              },
              child: _isPaused? Text('Resume') : Text('Pause'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<SessionProvider>().endSession();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SummaryScreen(
                      time: session.duration - session.remainingTime!,
                    ),
                  ),
                );
              },
              child: Text('End Session'),
            ),
          ],
        ),
      ),
    );
  }
}


