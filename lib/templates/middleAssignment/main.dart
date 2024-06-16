import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MiddleAssigmentApp()));
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Middle Assigment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class ShowerSession {
  final int sessionDuration;
  final int hotPhaseDuration;
  final int coldPhaseDuration;
  final String name;
  final String comments;

  ShowerSession({
    required this.sessionDuration,
    required this.hotPhaseDuration,
    required this.coldPhaseDuration,
    required this.name,
    required this.comments,
  });

  get duration => sessionDuration;

  get temperaturePhases => [
        TemperaturePhase(temperature: 'Hot', duration: hotPhaseDuration),
        TemperaturePhase(temperature: 'Cold', duration: coldPhaseDuration),
      ];

  Map<String, dynamic> toMap() {
    return {
      'sessionDuration': sessionDuration,
      'hotPhaseDuration': hotPhaseDuration,
      'coldPhaseDuration': coldPhaseDuration,
      'name': name,
      'comments': comments,
    };
  }

  factory ShowerSession.fromMap(Map<String, dynamic> map) {
    return ShowerSession(
      sessionDuration: map['sessionDuration'],
      hotPhaseDuration: map['hotPhaseDuration'],
      coldPhaseDuration: map['coldPhaseDuration'],
      name: map['name'],
      comments: map['comments'],
    );
  }
}

final showerSessionProvider = StateProvider<ShowerSession>((ref) {
  return ShowerSession(
    sessionDuration: 0,
    hotPhaseDuration: 0,
    coldPhaseDuration: 0,
    name: '',
    comments: '',
  );
});

class TemperaturePhase {
  String temperature;
  int duration;

  TemperaturePhase({required this.temperature, required this.duration});
}

class UserPreferences {
  int preferredSessionDuration;
  List<TemperaturePhase> preferredTemperatureIntervals;

  UserPreferences(
      {required this.preferredSessionDuration,
      required this.preferredTemperatureIntervals});
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ShowerSession>> _previousSessions;

  @override
  void initState() {
    super.initState();
    _previousSessions = _getPreviousSessions();
  }

  Future<List<ShowerSession>> _getPreviousSessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> sessionStrings = prefs.getStringList('sessions') ?? [];
    return sessionStrings.map((sessionString) {
      return ShowerSession.fromMap(jsonDecode(sessionString));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Shower Companion'),
      ),
      body: FutureBuilder(
        future: _previousSessions,
        builder: (context, AsyncSnapshot<List<ShowerSession>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].name),
                  subtitle: Text(
                      'Duration: ${snapshot.data![index].duration} seconds'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SessionDetailsScreen(
                          session: snapshot.data![index],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SessionPreferencesScreen()));
          setState(() {
            _previousSessions = _getPreviousSessions();
          });
        },
        tooltip: 'Start New Session',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SessionDetailsScreen extends StatelessWidget {
  final ShowerSession session;

  const SessionDetailsScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text('Session Duration: ${session.duration} seconds'),
            ...session.temperaturePhases.map((phase) => Text(
                'Phase: ${phase.temperature}, Duration: ${phase.duration} seconds')),
            Text('Comments: ${session.comments}'),
          ],
        ),
      ),
    );
  }
}

class SessionPreferencesScreen extends StatefulWidget {
  const SessionPreferencesScreen({super.key});

  @override
  _SessionPreferencesScreenState createState() =>
      _SessionPreferencesScreenState();
}

class _SessionPreferencesScreenState extends State<SessionPreferencesScreen> {
  String name = '';
  int sessionDurationSec = 0;
  int sessionDurationMin = 0;
  int hotPhaseDurationSec = 0;
  int coldPhaseDurationSec = 0;
  int hotPhaseDurationMin = 0;
  int coldPhaseDurationMin = 0;

  int sessionDuration = 0;
  int hotPhaseDuration = 0;
  int coldPhaseDuration = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Session name',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  sessionDurationMin = int.tryParse(value) ?? 0;
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Session Duration (minutes)',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  sessionDurationSec = int.tryParse(value) ?? 0;
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Session Duration (seconds)',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  hotPhaseDurationMin = int.tryParse(value) ?? 0;
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Hot Phase Duration (minutes)',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  hotPhaseDurationSec = int.tryParse(value) ?? 0;
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Hot Phase Duration (seconds)',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  coldPhaseDurationMin = int.tryParse(value) ?? 0;
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Cold Phase Duration (minutes)',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  coldPhaseDurationSec = int.tryParse(value) ?? 0;
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Cold Phase Duration (seconds)',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                sessionDuration = sessionDurationMin * 60 + sessionDurationSec;
                hotPhaseDuration =
                    hotPhaseDurationMin * 60 + hotPhaseDurationSec;
                coldPhaseDuration =
                    coldPhaseDurationMin * 60 + coldPhaseDurationSec;
                if (sessionDuration > 0 &&
                    hotPhaseDuration > 0 &&
                    coldPhaseDuration > 0 &&
                    sessionDurationSec < 60 &&
                    hotPhaseDurationSec < 60 &&
                    coldPhaseDurationSec < 60 &&
                    name.isNotEmpty &&
                    sessionDuration == hotPhaseDuration + coldPhaseDuration) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SessionOverviewScreen(
                        sessionDuration: sessionDuration,
                        hotPhaseDuration: hotPhaseDuration,
                        coldPhaseDuration: coldPhaseDuration,
                        name: name,
                      ),
                    ),
                  );
                } else {
                  // Show an error message if the durations are not properly set
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Please enter valid durations for all fields')),
                  );
                }
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class SessionOverviewScreen extends StatelessWidget {
  final int sessionDuration;
  final int hotPhaseDuration;
  final int coldPhaseDuration;
  final String name;

  const SessionOverviewScreen({
    super.key,
    required this.sessionDuration,
    required this.hotPhaseDuration,
    required this.coldPhaseDuration,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Session "$name" Overview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text('Session Duration: $sessionDuration seconds'),
            Text('Hot Phase Duration: $hotPhaseDuration seconds'),
            Text('Cold Phase Duration: $coldPhaseDuration seconds'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActiveSessionScreen(
                      sessionDuration: sessionDuration,
                      hotPhaseDuration: hotPhaseDuration,
                      coldPhaseDuration: coldPhaseDuration,
                      name: name,
                    ),
                  ),
                );
              },
              child: const Text('Begin Session'),
            ),
          ],
        ),
      ),
    );
  }
}

class ActiveSessionScreen extends StatefulWidget {
  final int sessionDuration;
  final int hotPhaseDuration;
  final int coldPhaseDuration;
  final String name;

  const ActiveSessionScreen({
    super.key,
    required this.sessionDuration,
    required this.hotPhaseDuration,
    required this.coldPhaseDuration,
    required this.name,
  });

  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class TimerController extends ChangeNotifier {
  late Timer _timer;
  int _remainingTime;
  String _currentPhase;

  TimerController(
      {required int sessionDuration,
      required int hotPhaseDuration,
      required int coldPhaseDuration})
      : _remainingTime = sessionDuration,
        // sessionDuration is now in seconds
        _currentPhase = 'Hot' {
    _startTimer(hotPhaseDuration, coldPhaseDuration);
  }

  int get remainingTime => _remainingTime;

  String get currentPhase => _currentPhase;

  void _startTimer(int hotPhaseDuration, int coldPhaseDuration) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingTime--;
      if (_remainingTime == hotPhaseDuration) {
        // hotPhaseDuration is now in seconds
        _currentPhase = 'Cold';
      } else if (_remainingTime == 0) {
        _currentPhase = 'End';
        _timer.cancel();
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> {
  late TimerController _timerController;
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _timerController = TimerController(
        sessionDuration: widget.sessionDuration,
        // sessionDuration is now in seconds
        hotPhaseDuration: widget.hotPhaseDuration,
        // hotPhaseDuration is now in seconds
        coldPhaseDuration:
            widget.coldPhaseDuration); // coldPhaseDuration is now in seconds
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_timerController.currentPhase == 'End') {
        setState(() {
          _opacity = _opacity == 1.0 ? 0.0 : 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Active Session: ${widget.name}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Session Duration: ${widget.sessionDuration} seconds'),
            // Display sessionDuration in seconds
            Text('Hot Phase Duration: ${widget.hotPhaseDuration} seconds'),
            // Display hotPhaseDuration in seconds
            Text('Cold Phase Duration: ${widget.coldPhaseDuration} seconds'),
            // Display coldPhaseDuration in seconds
            AnimatedBuilder(
              animation: _timerController,
              builder: (context, child) {
                Duration remaining =
                    Duration(seconds: _timerController.remainingTime);
                String minutes = remaining.inMinutes
                    .remainder(60)
                    .toString()
                    .padLeft(2, '0');
                String seconds = remaining.inSeconds
                    .remainder(60)
                    .toString()
                    .padLeft(2, '0');
                return AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    '$minutes:$seconds',
                    style: TextStyle(
                      fontSize: 48.0,
                      color: _timerController.currentPhase == 'Hot'
                          ? Colors.red
                          : _timerController.currentPhase == 'Cold'
                              ? Colors.blue
                              : Colors.green,
                    ),
                  ),
                );
              },
            ),
            // TODO: Display a large, animated timer indicating the current phase
            // TODO: Provide visual cues for phase transitions
            ElevatedButton(
              onPressed: () {
                // TODO: Implement pause functionality
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => SessionPausedScreen(
                //       sessionDuration: widget.sessionDuration,
                //       hotPhaseDuration: widget.hotPhaseDuration,
                //       coldPhaseDuration: widget.coldPhaseDuration,
                //     ),
                //   ),
                // );
              },
              child: const Text('Pause'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: end button in the middle of the training
                int actualSessionDuration =
                    widget.sessionDuration - _timerController.remainingTime;
                double hotColdRatio = widget.hotPhaseDuration /
                    (widget.hotPhaseDuration + widget.coldPhaseDuration);
                int actualHotPhaseDuration =
                    (actualSessionDuration * hotColdRatio).round();
                int actualColdPhaseDuration =
                    actualSessionDuration - actualHotPhaseDuration;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SessionSummaryScreen(
                      sessionDuration: actualSessionDuration,
                      hotPhaseDuration: actualHotPhaseDuration,
                      coldPhaseDuration: actualColdPhaseDuration,
                      name: widget.name,
                    ),
                  ),
                );
              },
              child: const Text('End Session'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }
}

class SessionSummaryScreen extends StatefulWidget {
  final int sessionDuration;
  final int hotPhaseDuration;
  final int coldPhaseDuration;
  final String name;

  const SessionSummaryScreen({
    super.key,
    required this.sessionDuration,
    required this.hotPhaseDuration,
    required this.coldPhaseDuration,
    required this.name,
  });

  @override
  _SessionSummaryScreenState createState() => _SessionSummaryScreenState();
}

class _SessionSummaryScreenState extends State<SessionSummaryScreen> {
  String comments = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Session ${widget.name} Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text('Session Duration: ${widget.sessionDuration} seconds'),
            Text('Hot Phase Duration: ${widget.hotPhaseDuration} seconds'),
            Text('Cold Phase Duration: ${widget.coldPhaseDuration} seconds'),
            TextField(
              onChanged: (value) {
                setState(() {
                  comments = value;
                });
              },
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Comments',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final newSession = ShowerSession(
                  sessionDuration: widget.sessionDuration,
                  hotPhaseDuration: widget.hotPhaseDuration,
                  coldPhaseDuration: widget.coldPhaseDuration,
                  name: widget.name,
                  comments: comments,
                );
                SharedPreferences prefs = await SharedPreferences.getInstance();
                List<String> sessionStrings =
                    prefs.getStringList('sessions') ?? [];
                sessionStrings.add(jsonEncode(newSession.toMap()));
                await prefs.setStringList('sessions', sessionStrings);
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
