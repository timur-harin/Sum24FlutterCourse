import 'package:flutter/material.dart';
import 'HistoryScreen.dart';
import 'SessionPreferencesScreen.dart';
import 'ShowerSessionForHistory.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<ShowerSessionForHistory> sessions = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shower App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            textStyle: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      home: HomeScreen(sessions: sessions),
      routes: {
        '/history': (context) => HistoryScreen(sessions: sessions),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  final List<ShowerSessionForHistory> sessions;

  HomeScreen({required this.sessions});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shower App',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SessionPreferencesScreen(sessions: widget.sessions),
                    ),
                  );
                },
                child: const Text(
                  'Start New Session',
                  style: TextStyle(color: Colors.amber),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/history');
                },
                child: const Text(
                  'View Previous Sessions',
                  style: TextStyle(color: Colors.amber),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.teal.shade50,
    );
  }
}
