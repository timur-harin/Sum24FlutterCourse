import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:shared_preferences/shared_preferences.dart';
import 'button.dart';
import 'star_rating.dart';
import 'theme.dart';
import 'package:provider/provider.dart';
import 'package:gradient_coloured_buttons/gradient_coloured_buttons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const riverpod.ProviderScope(child: MiddleAssigmentApp()),
  ));
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Middle Assigment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      home: HomeScreen(),
    );
  }
}

class ShowerSession {
  final String name;
  final String comments;
  final List<TemperaturePhase> temperaturePhases;
  final double rating;

  ShowerSession({
    required this.name,
    required this.comments,
    required this.temperaturePhases,
    required this.rating,
  });

  int get duration =>
      temperaturePhases.fold(0, (prev, phase) => prev + phase.duration);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'comments': comments,
      'temperaturePhases':
          temperaturePhases.map((phase) => phase.toMap()).toList(),
      'rating': rating,
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
      rating: map['rating'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShowerSession.fromJson(String source) =>
      ShowerSession.fromMap(json.decode(source));
}

final showerSessionProvider = riverpod.StateProvider<ShowerSession>((ref) {
  return ShowerSession(
    name: '',
    comments: '',
    temperaturePhases: [],
    rating: 0.0,
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Shower Companion'),
        actions: <Widget>[
          Switch.adaptive(
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _previousSessions,
        builder: (context, AsyncSnapshot<List<ShowerSession>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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
      floatingActionButton: GradientButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SessionPreferencesScreen()));
          setState(() {
            _previousSessions = _getPreviousSessions();
          });
        },
        text: 'Start New Session',
        gradientColors: [Colors.green, Colors.green.shade300],
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
            Text('Rating: ${session.rating}'),
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
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            phaseDurations[index].duration =
                                int.tryParse(value) ?? 0;
                          });
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText:
                              'Phase ${phaseDurations[index].temperature} Duration (seconds)',
                        ),
                      ),
                    ),
                    GradientButton(
                      text: 'Change temperature',
                      onPressed: () {
                        setState(() {
                          phaseDurations[index].temperature =
                              phaseDurations[index].temperature == 'Hot'
                                  ? 'Cold'
                                  : 'Hot';
                        });
                      },
                      gradientColors: phaseDurations[index].temperature == 'Hot'
                          ? [Colors.red, Colors.red.shade300]
                          : [Colors.blue, Colors.blue.shade300],
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          phaseDurations.removeAt(index);
                        });
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(2.0)),
                  ],
                );
              },
            ),
            const Padding(padding: EdgeInsets.all(2.0)),
            GradientButton(
              text: 'Add Phase',
              onPressed: () {
                setState(() {
                  phaseDurations.add(TemperaturePhase(
                    temperature: isHotPhase ? 'Hot' : 'Cold',
                    duration: 0,
                  ));
                  isHotPhase = !isHotPhase;
                });
              },
              gradientColors: isHotPhase
                  ? [Colors.red, Colors.red.shade300]
                  : [Colors.blue, Colors.blue.shade300],
            ),
            const Padding(padding: EdgeInsets.all(2.0)),
            GradientButton(
              text: 'Next',
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
                          rating: 0.0,
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
              gradientColors: [Colors.green, Colors.green.shade300],
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
            GradientButton(
              text: 'Begin Session',
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
              gradientColors: [Colors.green, Colors.green.shade300],
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

enum TimerState { paused, running }

class TimerController extends ChangeNotifier {
  Timer? _timer;
  int _remainingTime;
  String _currentPhase;
  List<TemperaturePhase> _phases;
  int _currentPhaseIndex;
  late TimerState _state = TimerState.running;
  ValueNotifier<String> currentPhaseNotifier = ValueNotifier<String>('Hot');

  TimerController({required List<TemperaturePhase> phases})
      : _remainingTime = phases.first.duration,
        _currentPhase = phases.first.temperature,
        _phases = phases,
        _currentPhaseIndex = 0 {
    _startTimer();
  }

  int get remainingTime => _remainingTime;

  String get currentPhase => _currentPhase;

  TimerState get state => _state;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingTime--;
      if (_remainingTime == 0) {
        _currentPhaseIndex++;
        if (_currentPhaseIndex < _phases.length) {
          currentPhaseNotifier.value = _phases[_currentPhaseIndex].temperature;
          _remainingTime = _phases[_currentPhaseIndex].duration;
        } else {
          currentPhaseNotifier.value = 'End';
          _timer?.cancel();
        }
      }
      notifyListeners();
    });
  }

  void _pauseTimer() {
    if (remainingTime > 0) {
      _state = TimerState.paused;
      _timer?.cancel();
      _timer = null;
      notifyListeners();
    }
  }

  void _unpauseTimer() {
    if (_timer == null && remainingTime > 0) {
      _state = TimerState.running;
      _startTimer();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen>
    with TickerProviderStateMixin {
  late TimerController _phaseTimerController;
  late TimerController _overallTimerController;
  late ValueNotifier<Color> _progressBarColor;
  late ValueNotifier<String> _currentPhaseNotifier;
  late Color _backgroundColor;
  late int _phaseDuration;
  late AnimationController _animationController;

  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _phaseTimerController =
        TimerController(phases: widget.session.temperaturePhases);
    _currentPhaseNotifier = _phaseTimerController.currentPhaseNotifier;
    _overallTimerController = TimerController(phases: [
      TemperaturePhase(
          temperature: 'Overall', duration: widget.session.duration)
    ]);
    _progressBarColor =
        ValueNotifier(_phaseTimerController.currentPhase == 'Hot'
            ? Colors.red
            : _phaseTimerController.currentPhase == 'Cold'
                ? Colors.blue
                : Colors.green);
    _backgroundColor = _progressBarColor.value;
    _phaseDuration = _phaseTimerController.remainingTime;
    _animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
    // other code...
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: _currentPhaseNotifier,
      builder: (context, currentPhase, child) {
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _animationController.value * 2.0 * pi,
              child: child,
            );
          },
          child: AnimatedContainer(
            duration: const Duration(seconds: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _backgroundColor,
                  Colors.white,
                ],
              ),
            ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('Active Session: ${widget.session.name}'),
            ),
            body: SingleChildScrollView(
              child: Center(
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
                    ValueListenableBuilder<Color>(
                      valueListenable: _progressBarColor,
                      builder: (context, color, child) {
                        if (currentPhase != 'End') {
                          return Column(
                            children: [
                              AnimatedBuilder(
                                animation: _overallTimerController,
                                builder: (context, child) {
                                  Duration remaining = Duration(
                                      seconds: _overallTimerController
                                          .remainingTime);
                                  String minutes = remaining.inMinutes
                                      .remainder(60)
                                      .toString()
                                      .padLeft(2, '0');
                                  String seconds = remaining.inSeconds
                                      .remainder(60)
                                      .toString()
                                      .padLeft(2, '0');
                                  return Text(
                                    'Total time left: $minutes:$seconds',
                                    style: const TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.black,
                                    ),
                                  );
                                },
                              ),
                              AnimatedBuilder(
                                animation: _phaseTimerController,
                                builder: (context, child) {
                                  Duration remaining = Duration(
                                      seconds:
                                          _phaseTimerController.remainingTime);
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
                                        color: currentPhase == 'Hot'
                                            ? Colors.red
                                            : currentPhase == 'Cold'
                                                ? Colors.blue
                                                : Colors.green,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              AnimatedBuilder(
                                animation: _phaseTimerController,
                                builder: (context, child) {
                                  return IconButton(
                                    icon: Icon(
                                      _phaseTimerController.state ==
                                              TimerState.paused
                                          ? Icons.play_arrow
                                          : Icons.pause,
                                      size: 48.0,
                                      color: _phaseTimerController.state ==
                                              TimerState.paused
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                                    onPressed: () {
                                      if (_phaseTimerController.state ==
                                          TimerState.paused) {
                                        _phaseTimerController._unpauseTimer();
                                        _overallTimerController._unpauseTimer();
                                      } else {
                                        _phaseTimerController._pauseTimer();
                                        _overallTimerController._pauseTimer();
                                      }
                                    },
                                  );
                                },
                              ),
                              GradientButton(
                                  text: 'End Session',
                                  onPressed: () {
                                    int timeLeft =
                                        _overallTimerController.remainingTime;
                                    // Stop the timers
                                    _phaseTimerController.dispose();
                                    _overallTimerController.dispose();

                                    // Navigate to the SessionSummaryScreen
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SessionSummaryScreen(
                                          session: widget.session,
                                        ),
                                      ),
                                    );
                                  },
                                  gradientColors:
                                      _overallTimerController.remainingTime == 0
                                          ? [
                                              Colors.green,
                                              Colors.green.shade300
                                            ]
                                          : [Colors.red, Colors.red.shade300]),
                            ],
                          );
                        } else {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              GradientButton(
                                  text: 'End Session',
                                  onPressed: () {
                                    int timeLeft =
                                        _overallTimerController.remainingTime;
                                    // Stop the timers
                                    _phaseTimerController.dispose();
                                    _overallTimerController.dispose();

                                    // Navigate to the SessionSummaryScreen
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SessionSummaryScreen(
                                          session: widget.session,
                                        ),
                                      ),
                                    );
                                  },
                                  gradientColors:
                                      _overallTimerController.remainingTime == 0
                                          ? [
                                              Colors.green,
                                              Colors.green.shade300
                                            ]
                                          : [Colors.red, Colors.red.shade300]),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        );
      },
    );
  }

  @override
  void dispose() {
    _phaseTimerController.dispose();
    _overallTimerController.dispose();
    _progressBarColor.dispose();
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
  double rating = 0.0; // Add this line to hold the current rating

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
            const Padding(padding: EdgeInsets.all(2.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text('Rate this session: '),
                StarRating(
                  rating: rating,
                  // Use the rating variable here
                  onRatingChanged: (newRating) =>
                      setState(() => rating = newRating),
                  // Update the rating variable when the rating changes
                  color: Colors.yellow,
                ),
              ],
            ),
            GradientButton(
              text: 'Save Session',
              onPressed: () async {
                final newSession = ShowerSession(
                  name: widget.session.name,
                  comments: comments,
                  temperaturePhases: widget.session.temperaturePhases,
                  rating: rating,
                );
                SharedPreferences prefs = await SharedPreferences.getInstance();
                List<String> sessionStrings =
                    prefs.getStringList('sessions') ?? [];
                sessionStrings.add(newSession.toJson());
                await prefs.setStringList('sessions', sessionStrings);
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              gradientColors: [Colors.green, Colors.green.shade300],
            ),
          ],
        ),
      ),
    );
  }
}
