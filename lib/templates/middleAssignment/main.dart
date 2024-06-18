import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  runApp(const MiddleAssignmentApp());
}


class MiddleAssignmentApp extends StatelessWidget {
  const MiddleAssignmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contrast Shower Companion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.lightBlue[50],
        appBarTheme: AppBarTheme(
          color: Colors.blue[900],
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue[700],
        ),
      ),
      home: HomeScreen(),
    );
  }
}
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contrast Shower Companion',
        style: TextStyle(
          color: Colors.white
        ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Placeholder for session history count
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Session ${index + 1}'),
                    subtitle: Text('Details of session ${index + 1}'),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SessionPreferencesScreen()),
                );
              },
              child: Text('Start New Session'),
            ),
          ],
        ),
      ),
    );
  }
}

class SessionPreferencesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Session Preferences'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ActiveSessionScreen()),
            );
          },
          child: Text('Begin Session'),
        ),
      ),
    );
  }
  
}


class ActiveSessionScreen extends StatefulWidget {
  @override
    _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> {

  int _remainingTime = 5; // Placeholder for remaining time
  bool _isHotPhase = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
        _startTimer();
      } else {
        _togglePhase();
      }
    });
  }

  void _togglePhase() {
    setState(() {
      _isHotPhase = !_isHotPhase;
      _remainingTime = 5; // Reset timer for the next phase
    });
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Active Session'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isHotPhase ? 'Hot Phase' : 'Cold Phase',
              style: TextStyle(
                fontSize: 24,
                color: _isHotPhase ? Colors.red : Colors.blue,
              ),
            ),
            Text(
              'Remaining Time: $_remainingTime seconds',
              style: TextStyle(fontSize: 24),
            ),
            // Add custom animation widget here
          ],
        ),
      ),
    );
  }

}
