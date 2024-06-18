import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    const ProviderScope(child: MiddleAssigmentApp())
    );
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Middle Assigment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contrast Shower Companion", style: TextStyle(fontSize: 48.0)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Session ${index + 1}:", style: const TextStyle(fontSize: 20.0)),
                    subtitle: const Text("Duration: 15 minutes, Rating: 20", style: TextStyle(fontSize: 16.0)),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SessionPreferencesScreen()),
                );
              },
              child: const Text('Start New Session', style: TextStyle(fontSize: 36.0),),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class SessionPreferencesScreen extends StatefulWidget {
  const SessionPreferencesScreen({super.key});
  @override
  State<StatefulWidget> createState() => _SessionPreferencesScreenState();
}

class _SessionPreferencesScreenState extends State<SessionPreferencesScreen> {
  int duration = 5;
  int hotInterval = 20;
  int coldInterval = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Session Preferences", style: TextStyle(fontSize: 48.0)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Text("Duration (minutes):", style: TextStyle(fontSize: 24.0)),
                Expanded(
                  child: Slider(
                    value: duration.toDouble(),
                    min: 5.0,
                    max: 30.0,
                    divisions: 5,
                    label: duration.toString(),
                    onChanged: (value) {
                      setState(() {
                        duration = value.round();
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const Text("Hot Interval (seconds):", style: TextStyle(fontSize: 24.0, color: Colors.red)),
                Expanded(
                  child: Slider(
                    value: hotInterval.toDouble(),
                    min: 10.0,
                    max: 60.0,
                    divisions: 5,
                    label: hotInterval.toString(),
                    onChanged: (value) {
                      setState(() {
                        hotInterval = value.round();
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const Text("Cold Interval (seconds):", style: TextStyle(fontSize: 24.0, color: Colors.blue)),
                Expanded(
                  child: Slider(
                    value: coldInterval.toDouble(),
                    min: 10.0,
                    max: 60.0,
                    divisions: 5,
                    label: coldInterval.toString(),
                    onChanged: (value) {
                      setState(() {
                        coldInterval = value.round();
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SessionOverviewScreen(
                            duration: duration,
                            hotInterval: hotInterval,
                            coldInterval: coldInterval,
                          )),
                );
              },
              child: const Text("Confirm", style: TextStyle(fontSize: 36.0),),
            ),
          ],
        ),
      ),
    );
  }
}

class SessionOverviewScreen extends StatefulWidget {
  final int duration;
  final int hotInterval;
  final int coldInterval;
  const SessionOverviewScreen({required this.duration, required this.hotInterval, required this.coldInterval, super.key});
  @override
  State<StatefulWidget> createState() => SessionOverviewScreenState();
  int getDuration() {
    return duration;
  }
  int getColdInterval() {
    return coldInterval;
  }
  int getHotInterval() {
    return hotInterval;
  }
}

class SessionOverviewScreenState extends State<SessionOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Session overview", style: TextStyle(fontSize: 48.0)),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget> [
            Text("Session duration: ${widget.getDuration()} minutes.", style: const TextStyle(fontSize: 24.0),),
            const SizedBox(height: 20.0,),
            Text("Hot interval: ${widget.getHotInterval()} seconds.", style: const TextStyle(fontSize: 24.0, color: Colors.red)),
            const SizedBox(height: 20.0,),
            Text("Cold interval: ${widget.getColdInterval()} seconds.", style: const TextStyle(fontSize: 24.0, color: Colors.blue)),
            const SizedBox(height: 20.0,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActiveSessionScreen(
                      duration: widget.getDuration(),
                      hotInterval: widget.getHotInterval(),
                      coldInterval: widget.getColdInterval(),
                    ),
                  ),
                );
              }, 
              child: const Text("Begin Session", style: TextStyle(fontSize: 36.0))
              )
          ],
        ),
        ),
    );
  }
}

class ActiveSessionScreen extends StatefulWidget {
  final int duration;
  final int hotInterval;
  final int coldInterval;
  const ActiveSessionScreen({required this.duration, required this.hotInterval, required this.coldInterval, super.key});
  @override
  State<StatefulWidget> createState() => ActiveSessionScreenState();
}

class ActiveSessionScreenState extends State<ActiveSessionScreen> {
  late Timer timer;
  int currentTime = 0;
  int totalTime = 60;
  bool isHot = true;
  bool isPaused = false;

  String formatTime(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2,'0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String second = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$second";
  }
  
  void pausedSession() {
    setState(() {
      isPaused = true;
    });
    timer.cancel();
  }

  void resumeSession() {
    setState(() {
      isPaused = false;
    });
    startSession();
  }

  void startSession() {
    currentTime = widget.hotInterval;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (currentTime > 0) {
          currentTime--;
          totalTime--;
        } else {
          if (isHot) {
            currentTime = widget.coldInterval;
            isHot = false;
          } else {
            currentTime = widget.hotInterval;
            isHot = true;
          }
        }
        if (totalTime == 0) {
          endSession();
        }
      });
    });
  }

  void endSession() {
    timer.cancel();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SessionSummaryScreen(
          duration: widget.duration,
          hotInterval: widget.hotInterval,
          coldInterval: widget.coldInterval,
        )
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    totalTime *= widget.duration;
    startSession();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Active Session", style: TextStyle(fontSize: 48.0)),),
      body: Center(
        child: Column(
          children: <Widget> [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                formatTime(currentTime),
                style: const TextStyle(
                  fontSize: 100.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              height: 300.0,
              color: isHot ? Colors.red : Colors.blue,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                ElevatedButton(
                  onPressed: isPaused ? resumeSession : pausedSession,
                  child: Text(isPaused ? "Resume" : "Pause", style: const TextStyle(fontSize: 36.0)),
                ),
                const SizedBox(width: 20.0,),
                ElevatedButton(
                  onPressed: endSession,
                  child: const Text("End Session", style: TextStyle(fontSize: 36.0))
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SessionSummaryScreen extends StatefulWidget {
  final int duration;
  final int hotInterval;
  final int coldInterval;
  const SessionSummaryScreen({required this.duration, required this.hotInterval, required this.coldInterval, super.key});
  
  @override
  State<StatefulWidget> createState() => SessionSummaryScreenState();
}

class SessionSummaryScreenState extends State<SessionSummaryScreen> {
  int rating = 5;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Session Summary", style: TextStyle(fontSize: 48.0)),),
      body: Center(
        child: Column(
          children: <Widget> [
            Text("Total duration: ${widget.duration} minutes", style: const TextStyle(fontSize: 24.0)),
            const SizedBox(height: 30.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                for (int i = 1; i <= 5; i++)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        rating = i;
                      });
                    },
                    icon: Icon(
                      i <= rating ? Icons.star : Icons.star_border,
                      color: i <= rating ? Colors.amber : Colors.grey,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text ("Save Session", style: TextStyle(fontSize: 36.0))
            ),
          ],
        ),
      ),
    );
  }
}