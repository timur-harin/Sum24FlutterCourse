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
  int hotDuration = 60; // Default 1 minute for hot water
  int coldDuration = 15; // Default 15 seconds for cold water
  Timer? timer;
  int remainingTime = 0;
  String _currentStage = 'Press Start to begin';
  Color _backgroundColor = Colors.red; // Initial background color

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
      hotDuration = prefs.getInt('hotDuration') ?? 60;
      coldDuration = prefs.getInt('coldDuration') ?? 15;
      _currentStage = prefs.getString('currentStage') ?? 'Press Start to begin';
      _backgroundColor = isHotWater ? Colors.red : Colors.blue;
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
    await prefs.setString('currentStage', _currentStage);
  }

  void _startSession() {
    setState(() {
      remainingTime = isHotWater ? hotDuration : coldDuration;
      _currentStage = isHotWater ? 'Turning on warm water' : 'Turning on cold water';
      _backgroundColor = isHotWater ? Colors.red : Colors.blue;
    });

    _saveSession();
    _startTimer();
  }

  void _startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          isHotWater = !isHotWater;
          remainingTime = isHotWater ? hotDuration : coldDuration;
          _currentStage = isHotWater ? 'Turning on warm water' : 'Turning on cold water';
          _backgroundColor = isHotWater ? Colors.red : Colors.blue;
          _saveSession();
        }
      });
    });
  }

  void _pauseTimer() {
    timer?.cancel();
    _saveSession();
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
        title: const Text('Контрастный Душ Контроль'),
      ),
      body: Container(
        color: _backgroundColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: remainingTime > 0 ? _pauseTimer : _startSession,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: Text(remainingTime > 0 ? 'Пауза' : 'Начать сеанс'),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Оставшееся время: $remainingTime секунд',
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Текущий этап: $_currentStage',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
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
