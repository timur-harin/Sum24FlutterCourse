import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(const ProviderScope(child: MiddleAssignmentApp()));
}

class MiddleAssignmentApp extends StatelessWidget {
  const MiddleAssignmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contrast Shower Companion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionHistory = ref.watch(sessionHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Контрастный Душ Контроль'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SessionPreferencesPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Start New Session'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: sessionHistory.length,
                itemBuilder: (context, index) {
                  final session = sessionHistory[index];
                  return ListTile(
                    title: Text('Session ${index + 1}: ${session.date}'),
                    subtitle: Text('Duration: ${session.totalDuration} seconds'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SessionPreferencesPage extends StatefulWidget {
  const SessionPreferencesPage({super.key});

  @override
  _SessionPreferencesPageState createState() => _SessionPreferencesPageState();
}

class _SessionPreferencesPageState extends State<SessionPreferencesPage> {
  int hotDuration = 60;
  int coldDuration = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Hot Water Duration (seconds)'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                hotDuration = int.parse(value);
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Cold Water Duration (seconds)'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                coldDuration = int.parse(value);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActiveSessionPage(
                      hotDuration: hotDuration,
                      coldDuration: coldDuration,
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

class ActiveSessionPage extends StatefulWidget {
  final int hotDuration;
  final int coldDuration;

  const ActiveSessionPage({
    super.key,
    required this.hotDuration,
    required this.coldDuration,
  });

  @override
  _ActiveSessionPageState createState() => _ActiveSessionPageState();
}

class _ActiveSessionPageState extends State<ActiveSessionPage> {
  late int remainingTime;
  late bool isHotWater;
  Timer? timer;
  late DateTime startTime;

  @override
  void initState() {
    super.initState();
    isHotWater = true;
    remainingTime = widget.hotDuration;
    startTime = DateTime.now();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          isHotWater = !isHotWater;
          remainingTime = isHotWater ? widget.hotDuration : widget.coldDuration;
        }
      });
    });
  }

  void _pauseTimer() {
    timer?.cancel();
    _saveSession();
  }

  Future<void> _saveSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isHotWater', isHotWater);
    await prefs.setInt('remainingTime', remainingTime);
    await prefs.setInt('hotDuration', widget.hotDuration);
    await prefs.setInt('coldDuration', widget.coldDuration);
    await prefs.setString('currentStage', isHotWater ? 'Turning on warm water' : 'Turning on cold water');
  }

  Future<void> _endSession(BuildContext context) async {
    timer?.cancel();
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime).inSeconds;

    final session = ShowerSession(
      date: endTime.toIso8601String(),
      totalDuration: duration,
    );

    // Access the sessionHistoryProvider using ProviderContainer
    final container = ProviderContainer();
    final sessionHistoryNotifier = container.read(sessionHistoryProvider.notifier);
    sessionHistoryNotifier.addSession(session);

    // Navigate back to the previous screen
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _endSession(context); // Pass context to _endSession method
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Session'),
      ),
      body: Container(
        color: isHotWater ? Colors.red : Colors.blue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Remaining Time: $remainingTime seconds',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pauseTimer,
                child: const Text('Pause'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowerSession {
  final String date;
  final int totalDuration;

  ShowerSession({
    required this.date,
    required this.totalDuration,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'totalDuration': totalDuration,
    };
  }

  static ShowerSession fromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return ShowerSession(
      date: json['date'],
      totalDuration: json['totalDuration'],
    );
  }
}

final sessionHistoryProvider = StateNotifierProvider<SessionHistoryNotifier, List<ShowerSession>>((ref) {
  return SessionHistoryNotifier();
});

class SessionHistoryNotifier extends StateNotifier<List<ShowerSession>> {
  SessionHistoryNotifier() : super([]) {
    _loadSessionHistory();
  }

  void addSession(ShowerSession session) {
    state = [...state, session];
    _saveSessionHistory();
  }

  Future<void> _loadSessionHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionData = prefs.getStringList('sessionHistory') ?? [];
    state = sessionData.map((e) => ShowerSession.fromJson(e)).toList();
  }

  Future<void> _saveSessionHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionData = state.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('sessionHistory', sessionData);
  }
}
