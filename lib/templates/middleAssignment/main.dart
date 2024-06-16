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
  final String name;
  final String comments;
  final List<TemperaturePhase> temperaturePhases;

  ShowerSession({
    required this.name,
    required this.comments,
    required this.temperaturePhases,
  });

  int get duration =>
      temperaturePhases.fold(0, (prev, phase) => prev + phase.duration);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'comments': comments,
      'temperaturePhases':
          temperaturePhases.map((phase) => phase.toMap()).toList(),
    };
  }

  factory ShowerSession.fromMap(Map<String, dynamic> map) {
    var temperaturePhasesFromMap = (map['temperaturePhases'] as List)
        .map((item) => TemperaturePhase.fromMap(item))
        .toList();
    return ShowerSession(
      name: map['name'],
      comments: map['comments'],
      temperaturePhases: temperaturePhasesFromMap,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShowerSession.fromJson(String source) =>
      ShowerSession.fromMap(json.decode(source));
}

final showerSessionProvider = StateProvider<ShowerSession>((ref) {
  return ShowerSession(
    name: '',
    comments: '',
    temperaturePhases: [],
  );
});

class TemperaturePhase {
  String temperature;
  int duration;

  TemperaturePhase({required this.temperature, required this.duration});

  Map<String, dynamic> toMap() {
    return {
      'temperature': temperature,
      'duration': duration,
    };
  }

  factory TemperaturePhase.fromMap(Map<String, dynamic> map) {
    return TemperaturePhase(
      temperature: map['temperature'],
      duration: map['duration'],
    );
  }
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
  List<TemperaturePhase> phaseDurations = [];
  bool isHotPhase = true;

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
            ListView.builder(
              shrinkWrap: true,
              itemCount: phaseDurations.length,
              itemBuilder: (context, index) {
                return TextField(
                  onChanged: (value) {
                    setState(() {
                      phaseDurations[index].duration = int.tryParse(value) ?? 0;
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText:
                        'Phase ${phaseDurations[index].temperature} Duration (seconds)',
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  phaseDurations.add(TemperaturePhase(
                    temperature: isHotPhase ? 'Hot' : 'Cold',
                    duration: 0,
                  ));
                  isHotPhase = !isHotPhase;
                });
              },
              child: const Text('Add Phase'),
            ),
            ElevatedButton(
              onPressed: () {
                if (phaseDurations.every((phase) => phase.duration > 0) &&
                    name.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SessionOverviewScreen(
                        session: ShowerSession(
                          name: name,
                          comments: '',
                          temperaturePhases: phaseDurations,
                        ),
                      ),
                    ),
                  );
                } else {
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
  final ShowerSession session;

  const SessionOverviewScreen({
    super.key,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Session "${session.name}" Overview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              itemCount: session.temperaturePhases.length,
              itemBuilder: (context, index) {
                return Text(
                    'Phase: ${session.temperaturePhases[index].temperature}, Duration: ${session.temperaturePhases[index].duration} seconds');
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActiveSessionScreen(
                      session: session,
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
  final ShowerSession session;

  const ActiveSessionScreen({
    super.key,
    required this.session,
  });

  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class TimerController extends ChangeNotifier {
  late Timer _timer;
  int _remainingTime;
  String _currentPhase;
  List<TemperaturePhase> _phases;
  int _currentPhaseIndex;

  TimerController({required List<TemperaturePhase> phases})
      : _remainingTime = phases.first.duration,
        _currentPhase = phases.first.temperature,
        _phases = phases,
        _currentPhaseIndex = 0 {
    _startTimer();
  }

  int get remainingTime => _remainingTime;

  String get currentPhase => _currentPhase;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingTime--;
      if (_remainingTime == 0) {
        _currentPhaseIndex++;
        if (_currentPhaseIndex < _phases.length) {
          _currentPhase = _phases[_currentPhaseIndex].temperature;
          _remainingTime = _phases[_currentPhaseIndex].duration;
        } else {
          _currentPhase = 'End';
          _timer.cancel();
        }
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
  late TimerController _phaseTimerController;
  late TimerController _overallTimerController;
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _phaseTimerController =
        TimerController(phases: widget.session.temperaturePhases);
    _overallTimerController = TimerController(phases: [
      TemperaturePhase(
          temperature: 'Overall', duration: widget.session.duration)
    ]);
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_phaseTimerController.currentPhase == 'End') {
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
        title: Text('Active Session: ${widget.session.name}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.session.temperaturePhases.length,
              itemBuilder: (context, index) {
                return Text(
                    'Phase: ${widget.session.temperaturePhases[index].temperature}, Duration: ${widget.session.temperaturePhases[index].duration} seconds');
              },
            ),
            AnimatedBuilder(
              animation: _phaseTimerController,
              builder: (context, child) {
                Duration remaining =
                    Duration(seconds: _phaseTimerController.remainingTime);
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
                      color: _phaseTimerController.currentPhase == 'Hot'
                          ? Colors.red
                          : _phaseTimerController.currentPhase == 'Cold'
                              ? Colors.blue
                              : Colors.green,
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _overallTimerController,
              builder: (context, child) {
                Duration remaining =
                    Duration(seconds: _overallTimerController.remainingTime);
                String minutes = remaining.inMinutes
                    .remainder(60)
                    .toString()
                    .padLeft(2, '0');
                String seconds = remaining.inSeconds
                    .remainder(60)
                    .toString()
                    .padLeft(2, '0');
                return Text(
                  'Overall Time: $minutes:$seconds',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
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
                    widget.session.duration - _overallTimerController.remainingTime;
                int actualHotPhaseDuration = widget.session.temperaturePhases
                        .firstWhere((phase) => phase.temperature == 'Hot')
                        .duration -
                    _overallTimerController.remainingTime;
                int actualColdPhaseDuration = widget.session.temperaturePhases
                        .firstWhere((phase) => phase.temperature == 'Cold')
                        .duration -
                    _overallTimerController.remainingTime;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SessionSummaryScreen(
                      session: ShowerSession(
                        name: widget.session.name,
                        comments: '',
                        temperaturePhases: widget.session.temperaturePhases,
                      ),
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
    _phaseTimerController.dispose();
    _overallTimerController.dispose();
    super.dispose();
  }
}

class SessionSummaryScreen extends StatefulWidget {
  final ShowerSession session;

  const SessionSummaryScreen({
    super.key,
    required this.session,
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
        title: Text('Session ${widget.session.name} Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ...widget.session.temperaturePhases.map((phase) => Text(
                'Phase: ${phase.temperature}, Duration: ${phase.duration} seconds')),
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
                  name: widget.session.name,
                  comments: comments,
                  temperaturePhases: widget.session.temperaturePhases,
                );
                SharedPreferences prefs = await SharedPreferences.getInstance();
                List<String> sessionStrings =
                    prefs.getStringList('sessions') ?? [];
                sessionStrings.add(newSession.toJson());
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
