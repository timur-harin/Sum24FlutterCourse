import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

void main() {
  runApp(const ProviderScope(child: MiddleAssigmentApp()));
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Middle Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.red,
      ),
      home: const HomeScreen(),
    );
  }
}

class ShowerSession {
  final DateTime startTime;
  final int duration;
  final int temperatureInterval;
  final String status;

  ShowerSession({required this.startTime, required this.duration, required this.temperatureInterval, required this.status});
}

final sessionHistoryProvider = StateNotifierProvider<SessionHistory, List<ShowerSession>>((ref) {
  return SessionHistory();
});

class SessionHistory extends StateNotifier<List<ShowerSession>> {
  SessionHistory() : super([]) {
    _loadHistory();
  }

  void addSession(int duration, int temperatureInterval) {
    final newSession = ShowerSession(
      startTime: DateTime.now(),
      duration: duration,
      temperatureInterval: temperatureInterval,
      status: 'Running',
    );
    state = [...state, newSession];
    _saveHistory();
  }

  void updateSession(int index, String status) {
    final updatedSession = ShowerSession(
      startTime: state[index].startTime,
      duration: state[index].duration,
      temperatureInterval: state[index].temperatureInterval,
      status: status,
    );
    final updatedHistory = List<ShowerSession>.from(state);
    updatedHistory[index] = updatedSession;
    state = updatedHistory;
    _saveHistory();
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('history', state.map((session) => '${session.startTime}|${session.duration}|${session.temperatureInterval}|${session.status}').toList());
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('history') ?? [];
    state = history.map((entry) {
      final parts = entry.split('|');
      return ShowerSession(
        startTime: DateTime.parse(parts[0]),
        duration: int.parse(parts[1]),
        temperatureInterval: int.parse(parts[2]),
        status: parts[3],
      );
    }).toList();
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionHistory = ref.watch(sessionHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Contrast Shower')),
      body: ListView.builder(
        itemCount: sessionHistory.length,
        itemBuilder: (context, index) {
          final session = sessionHistory[index];
          final durationMinutes = session.duration ~/ 60;
          final durationSeconds = session.duration % 60;
          return ListTile(
            title: Text('${durationMinutes.toString().padLeft(2, '0')}:${durationSeconds.toString().padLeft(2, '0')}'),
            subtitle: Text('${session.temperatureInterval}° interval | ${session.status}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Consumer(builder: (context, ref, _) => SessionPreferences(ref: ref),)),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SessionPreferences extends StatefulWidget {
  final WidgetRef ref;

  const SessionPreferences({super.key, required this.ref});

  @override
  State<SessionPreferences> createState() => _SessionPreferencesState();
}

class _SessionPreferencesState extends State<SessionPreferences> {
  int _duration = 10;
  int _temperatureInterval = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Session Preferences')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Duration:'),
            Slider(
              value: _duration.toDouble(),
              min: 1,
              max: 30,
              divisions: 29,
              label: _duration.toString(),
              onChanged: (value) {
                setState(() {
                  _duration = value.round();
                });
              },
            ),
            Text('Temperature Interval:'),
            Slider(
              value: _temperatureInterval.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: _temperatureInterval.toString(),
              onChanged: (value) {
                setState(() {
                  _temperatureInterval = value.round();
                });
              },
            ),
            Consumer(
              builder: (context, ref, _) {
                return ElevatedButton(
                  onPressed: () {
                    ref.read(sessionHistoryProvider.notifier).addSession(_duration, _temperatureInterval);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ActiveSessionScreen(duration: _duration, temperatureInterval: _temperatureInterval, sessionIndex: ref.watch(sessionHistoryProvider).length - 1, ref: ref)),
                    );
                  },
                  child: const Text('Start Session'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ActiveSessionScreen extends StatefulWidget {
  final int duration;
  final int temperatureInterval;
  final int sessionIndex;
  final WidgetRef ref;

  const ActiveSessionScreen({super.key, required this.duration, required this.temperatureInterval, required this.sessionIndex, required this.ref});

  @override
  State<ActiveSessionScreen> createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> {
  bool _isHot = true;
  int _remainingTime = 0;
  late Timer _timer;
  bool _isPaused = false;

  Color _getTemperatureColor() {
    return _isHot ? Colors.red : Colors.blue;
  }

  void _stopSession(String status) {
    _timer.cancel();
    widget.ref.read(sessionHistoryProvider.notifier).updateSession(widget.sessionIndex, status);
    if (status == 'Completed') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Session Completed'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Total time: ${widget.duration} seconds'),
                Text('Phases completed: ${(_remainingTime ~/ widget.temperatureInterval) + 1}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else if (status == 'Paused') {
      setState(() {
        _isPaused = true;
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _resumeSession() {
    if (_isPaused) {
      setState(() {
        _isPaused = false;
      });
    }
    _timer = Timer.periodic(Duration(seconds: widget.temperatureInterval), (timer) {
      setState(() {
        _isHot = !_isHot;
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          timer.cancel();
          widget.ref.read(sessionHistoryProvider.notifier).updateSession(widget.sessionIndex, 'Completed');
          _stopSession('Completed');
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.duration;
    _resumeSession();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Active Session')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              color: _getTemperatureColor(),
            ),
            SizedBox(height: 10), // Add some space between the square and the text
            Text(_isHot ? 'Hot' : 'Cold', style: Theme.of(context).textTheme.headlineMedium),
            Text('$_remainingTime seconds remaining', style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _stopSession('Stopped'),
            child: const Icon(Icons.close),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: _isPaused ? _resumeSession : () => _stopSession('Paused'),
            child: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
          ),
        ],
      ),
    );
  }
}
