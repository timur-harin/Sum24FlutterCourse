import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MiddleAssignmentApp()));
}

class MiddleAssignmentApp extends StatelessWidget {
  const MiddleAssignmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Контрастный Душ',
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
    final showerHistory = ref.watch(showerHistoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Контрастный Душ'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: showerHistory.length,
              itemBuilder: (context, index) {
                final session = showerHistory[index];
                return ListTile(
                  title: Text('Сеанс ${index + 1}: ${session.date}'),
                  subtitle: Text('Горячая: ${session.hotDuration}s, Холодная: ${session.coldDuration}s'),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SessionSettingsPage()),
            ),
            child: const Text('Начать новый сеанс'),
          ),
        ],
      ),
    );
  }
}

class SessionSettingsPage extends StatelessWidget {
  const SessionSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки сеанса'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SessionPage(hotDuration: 60, coldDuration: 15)),
                );
              },
              child: const Text('Базовый сеанс'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SessionPage(hotDuration: 120, coldDuration: 30)),
                );
              },
              child: const Text('Средний сеанс'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SessionPage(hotDuration: 180, coldDuration: 60)),
                );
              },
              child: const Text('Интенсивный сеанс'),
            ),
          ],
        ),
      ),
    );
  }
}

class SessionPage extends ConsumerStatefulWidget {
  final int hotDuration;
  final int coldDuration;

  const SessionPage({required this.hotDuration, required this.coldDuration, super.key});

  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends ConsumerState<SessionPage> {
  bool isHotWater = true;
  int remainingTime = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.hotDuration;
    _startTimer();
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          isHotWater = !isHotWater;
          remainingTime = isHotWater ? widget.hotDuration : widget.coldDuration;
        }
        ref.read(sessionStateProvider.notifier).updateSession(isHotWater, remainingTime);
      });
    });
  }

  void _stopTimer() {
    timer?.cancel();
    ref.read(sessionStateProvider.notifier).endSession(widget.hotDuration, widget.coldDuration);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Активный сеанс'),
        actions: [
          IconButton(
            icon: const Icon(Icons.stop),
            onPressed: _stopTimer,
          ),
        ],
      ),
      body: Container(
        color: isHotWater ? Colors.redAccent : Colors.blueAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Текущая вода: ${isHotWater ? 'Горячая' : 'Холодная'}',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                'Оставшееся время: $remainingTime секунд',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Define the ShowerSession class
class ShowerSession {
  final String date;
  final int hotDuration;
  final int coldDuration;

  ShowerSession(this.date, this.hotDuration, this.coldDuration);

  Map<String, dynamic> toJson() => {
        'date': date,
        'hotDuration': hotDuration,
        'coldDuration': coldDuration,
      };

  static ShowerSession fromJson(Map<String, dynamic> json) {
    return ShowerSession(
      json['date'],
      json['hotDuration'],
      json['coldDuration'],
    );
  }
}

// Define providers for managing the session state and history
final sessionStateProvider = StateNotifierProvider<SessionStateNotifier, List<ShowerSession>>((ref) {
  return SessionStateNotifier();
});

final showerHistoryProvider = Provider<List<ShowerSession>>((ref) {
  return ref.watch(sessionStateProvider);
});

class SessionStateNotifier extends StateNotifier<List<ShowerSession>> {
  SessionStateNotifier() : super([]) {
    _loadHistory();
  }

  void updateSession(bool isHotWater, int remainingTime) {
    // Update the session state (could include more detailed logic)
  }

  void endSession(int hotDuration, int coldDuration) {
    final date = DateTime.now().toIso8601String();
    final newSession = ShowerSession(date, hotDuration, coldDuration);
    state = [...state, newSession];
    _saveHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyData = prefs.getStringList('showerHistory') ?? [];
    final history = historyData.map((e) => ShowerSession.fromJson(json.decode(e) as Map<String, dynamic>)).toList();
    state = history;
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyData = state.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList('showerHistory', historyData);
  }
}
