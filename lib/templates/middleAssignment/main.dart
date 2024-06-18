import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MiddleAssignmentApp());
}

class MiddleAssignmentApp extends StatelessWidget {
  const MiddleAssignmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Middle Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isHotWater = true;
  int hotDuration = 0;
  int coldDuration = 0;
  Timer? timer;
  int remainingTime = 0;

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isHotWater = prefs.getBool('isHotWater') ?? true;
      remainingTime = prefs.getInt('remainingTime') ?? 0;
      hotDuration = prefs.getInt('hotDuration') ?? 0;
      coldDuration = prefs.getInt('coldDuration') ?? 0;
      if (remainingTime > 0) {
        _startTimer();
      }
    });
  }

  Future<void> _saveSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isHotWater', isHotWater);
    await prefs.setInt('remainingTime', remainingTime);
    await prefs.setInt('hotDuration', hotDuration);
    await prefs.setInt('coldDuration', coldDuration);
  }

  void _startSession(int hot, int cold) {
    setState(() {
      hotDuration = hot;
      coldDuration = cold;
      remainingTime = isHotWater ? hotDuration : coldDuration;
    });

    _saveSession();
    _startTimer();
  }

  void _startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          isHotWater = !isHotWater;
          remainingTime = isHotWater ? hotDuration : coldDuration;
        }
        _saveSession();
      });
    });
  }

  void _stopTimer() async {
    timer?.cancel();
    await _resetSession();
  }

  void _pauseTimer() {
    timer?.cancel();
  }

  void _resumeTimer() {
    _startTimer();
  }

  Future<void> _resetSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isHotWater');
    await prefs.remove('remainingTime');
    await prefs.remove('hotDuration');
    await prefs.remove('coldDuration');
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _startBasicSession() {
    _startSession(60, 15); // 1 минута горячей воды, 15 секунд холодной
  }

  void _startMediumSession() {
    _startSession(120, 30); // 2 минуты горячей воды, 30 секунд холодной
  }

  void _startIntensiveSession() {
    _startSession(180, 60); // 3 минуты горячей воды, 1 минута холодной
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Контрастный Душ Контроль'),
      ),
      body: Container(
        color: isHotWater ? Colors.redAccent : Colors.blueAccent,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: _startBasicSession,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Базовый сеанс'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _startMediumSession,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Средний сеанс'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _startIntensiveSession,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Интенсивный сеанс'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _stopTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Остановить'),
                ),
                
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _resumeTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Продолжить'),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Текущая вода: ${isHotWater ? 'Горячая' : 'Холодная'}',
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'Оставшееся время: $remainingTime секунд',
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
