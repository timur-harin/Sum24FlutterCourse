import 'package:flutter/material.dart';
import 'SessionScreen.dart'; 
import 'main.dart';

class SessionSummary extends StatelessWidget {
  final ShowerSession session;

  SessionSummary({required this.session});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Summary'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Session Summary',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Session Duration: ${session.preferences.sessionDuration} seconds',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Hot Water Duration: ${session.preferences.hotWaterDuration} seconds',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Cold Water Duration: ${session.preferences.coldWaterDuration} seconds',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  session.preferences.startWithHotWater ? 'Started with Hot Water' : 'Started with Hot Water',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Phases Completed: ${session.phasesCompleted}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (Route<dynamic> route) => false, 
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Back', style: TextStyle(color: Colors.amber)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
