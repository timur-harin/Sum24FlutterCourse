import 'package:flutter/material.dart';
import 'active_session_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Start the active session
            startActiveSession(context);
          },
          child: const Text('Start Active Session'),
        ),
      ),
    );
  }

  void startActiveSession(BuildContext context) {
    // Set the duration and callback function for when the session ends
    Duration sessionDuration = const Duration(minutes: 2);
    onSessionEnd() {
      // Perform any actions when the session ends
      // For example, navigate to a different screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SessionEndScreen(),
        ),
      );
    }

    // Navigate to the active session screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ActiveSessionScreen(
          currentPhase: 'Phase 1',
          initialRemainingTime1: sessionDuration,
          initialRemainingTime2: sessionDuration,
          onSessionEnd: onSessionEnd,
        ),
      ),
    );
  }
}

class SessionEndScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Ended'),
      ),
      body: const Center(
        child: Text(
          'Session has ended.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}