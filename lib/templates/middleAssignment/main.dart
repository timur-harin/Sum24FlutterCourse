import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MiddleAssigmentApp());
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Middle Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProviderScope(
        child: HomeScreen(),
      ),
    );
  }
}
// Riverpod providers 
final durationProvider = StateProvider<double>((ref) => 30.0); // Default duration
final temperatureProvider =
    StateProvider<double>((ref) => 25.0);



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _sessions = [];
  Map<String, Map<String, dynamic>> _sessionDetails = {};

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  // Load sessions and session details from SharedPreferences
  Future<void> _loadSessions() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> sessions = prefs.getStringList('sessions') ?? [];
    Map<String, Map<String, dynamic>> sessionDetails = {};
    for (String session in sessions) {
      sessionDetails[session] = {
        'rating': prefs.getInt('rating_$session') ?? 0,
        'totalTime': prefs.getDouble('totalTime_$session') ?? 0.0,
        'phasesCompleted': prefs.getInt('phasesCompleted_$session') ?? 0,
      };
    }
    setState(() {
      _sessions = sessions.reversed.toList(); // Reverse the order to show the most recent first
      _sessionDetails = sessionDetails;
    });
  }

  // Save sessions to SharedPreferences
  Future<void> _addSession() async {
    final prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    String formattedDate =
        "${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute}";

    _sessions.add(formattedDate); // Add new session to the list
    await prefs.setStringList('sessions', _sessions); // Save updated list to SharedPreferences
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 159, 200, 219),
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Shower Sessions",
            style: TextStyle(
              color: Color.fromARGB(255, 10, 44, 71),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Expanded(
              child: ListView.builder(
                itemCount: _sessions.length,
                itemBuilder: (context, index) {
                  String session = _sessions[index];
                  int rating = _sessionDetails[session]?['rating'] ?? 0;
                  double totalTime = _sessionDetails[session]?['totalTime'] ?? 0.0;
                  int phasesCompleted = _sessionDetails[session]?['phasesCompleted'] ?? 0;
                  return ListTile(
                    title: Text(session),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Time: ${totalTime.toStringAsFixed(2)} minutes'),
                        Text('Phases Completed: $phasesCompleted'),
                        Row(
                          children: List.generate(rating, (starIndex) {
                            return Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 200, 183, 35),
                            );
                          }),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 255, 255, 255)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 10, 44, 71)),
                ),
                onPressed: () async {
                  await _addSession();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PreferencesScreen()),
                  ).then((_) => _loadSessions());
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    'Start New Session',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PreferencesScreen extends StatefulWidget {
  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final TextEditingController _durationController =
      TextEditingController(text: '30');
  final TextEditingController _temperatureController =
      TextEditingController(text: '25');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 159, 200, 219),
      appBar: AppBar(
          title: Container(
        child: const Center(
            child: Text(
          "Settings",
          style: TextStyle(
            color: Color.fromARGB(255, 10, 44, 71),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )),
      )),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              title: const Text('Session Duration',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Slider(
                value: _durationController.text.isEmpty
                    ? 30
                    : double.parse(_durationController.text),
                min: 3,
                max: 60,
                divisions: 30,
                label: _durationController.text.isNotEmpty
                    ? _durationController.text
                    : '',
                onChanged: (double value) {
                  setState(() {
                    _durationController.text = value.round().toString();
                  });
                },
                activeColor: Color.fromARGB(255, 10, 44, 71),
              ),
            ),
            ListTile(
              title: const Text('Temperature Interval',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Slider(
                value: _temperatureController.text.isEmpty
                    ? 25
                    : double.parse(_temperatureController.text),
                min: 10,
                max: 40,
                divisions: 15,
                label: _temperatureController.text.isNotEmpty
                    ? _temperatureController.text
                    : '',
                onChanged: (double value) {
                  setState(() {
                    _temperatureController.text = value.round().toString();
                  });
                },
                activeColor: Color.fromARGB(255, 10, 44, 71),
              ),
            ),
            SizedBox(height: 20), // Add some space between elements
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 255, 255, 255)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 10, 44, 71)),
                ),
                onPressed: () {
                  double? duration = double.tryParse(_durationController.text);
                  double? temperature =
                      double.tryParse(_temperatureController.text);

                  if (duration != null && temperature != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OverviewScreen(
                          duration: duration,
                          temperature: temperature,
                        ),
                      ),
                    );
                  } else {
                    // Show an error message if the inputs are invalid
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Invalid input. Please enter valid numbers.'),
                      ),
                    );
                  }
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    'Save Preferences',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OverviewScreen extends StatelessWidget {
  final double duration;
  final double temperature;

  const OverviewScreen(
      {Key? key, required this.duration, required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 159, 200, 219),
      appBar: AppBar(
        title: Container(
          child: const Center(
              child: Text(
            "Sessions Overview",
            style: TextStyle(
              color: Color.fromARGB(255, 10, 44, 71),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Session Duration: ${duration.toString()} minutes'),
              const SizedBox(height: 10),
              Text('Temperature Interval: ${temperature.toString()} degrees'),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 255, 255, 255)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 10, 44, 71)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TimerScreen(
                          duration: duration,
                          temperature: temperature,
                        ),
                      ),
                    );
                  },
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Text(
                      'Begin Session',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerScreen extends StatefulWidget {
  final double duration;
  final double temperature;

  const TimerScreen(
      {Key? key, required this.duration, required this.temperature});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with SingleTickerProviderStateMixin {
  late int _remainingTime;
  late double _temperature;
  bool _isRunning = false;
  late Timer _timer;
  bool _isHotPhase = true;
  late final AudioPlayer _audioPlayer;
  int _phasesCompleted = 0;
  int _elapsedTime = 0; // Add this variable to track elapsed time

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _remainingTime = (widget.duration * 60).toInt();
    _startTimer();
  }

  void _startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
          _elapsedTime++; // Increment elapsed time
          if (_remainingTime % 60 == 0) {
            _isHotPhase = !_isHotPhase;
            _phasesCompleted++;
            _audioPlayer.play(AssetSource('sounds/transition.mp3'));
          }
        });
      } else {
        timer.cancel();
        _isRunning = false;
        _endSession();
      }
    });
  }

  void _pauseTimer() {
    if (_isRunning) {
      _timer.cancel();
      setState(() {
        _isRunning = false;
      });
    } else {
      _startTimer();
      setState(() {
        _isRunning = true;
      });
    }
  }

  void _endSession() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryScreen(
          totalTime: _elapsedTime / 60, // Pass the real elapsed time
          phasesCompleted: _phasesCompleted,
          session: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}", // Pass the session date-time string
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_isRunning) {
      _timer.cancel();
    }
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isHotPhase ? const Color.fromARGB(255, 181, 67, 59) : Color.fromARGB(255, 64, 125, 175),
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Shower Timer",
          style: TextStyle(
            color: Color.fromARGB(255, 10, 44, 71),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                color: _isHotPhase ? const Color.fromARGB(255, 181, 67, 59) : Color.fromARGB(255, 64, 125, 175),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Time Remaining: ${(_remainingTime ~/ 60).toString().padLeft(2, '0')}:${(_remainingTime % 60).toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Current Phase: ${_isHotPhase ? 'Hot' : 'Cold'}',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Temperature changes every 1 minute', // Temperature change caption
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 10, 44, 71)),
                      ),
                      onPressed: _pauseTimer,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Text(
                          _isRunning ? 'Pause' : 'Resume',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 10, 44, 71)),
                      ),
                      onPressed: _endSession,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Text(
                          'End Session',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SummaryScreen extends StatefulWidget {
  final double totalTime;
  final int phasesCompleted;
  final String session;

  const SummaryScreen(
      {Key? key, required this.totalTime, required this.phasesCompleted, required this.session})
      : super(key: key);

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  int _rating = 0;

  Future<void> _saveRating(int rating) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('rating_${widget.session}', rating);
    await prefs.setDouble('totalTime_${widget.session}', widget.totalTime);
    await prefs.setInt('phasesCompleted_${widget.session}', widget.phasesCompleted);
  }

  @override
  Widget build(BuildContext context) {
    // Convert totalTime to minutes and seconds
    int minutes = widget.totalTime.toInt();
    int seconds = ((widget.totalTime - minutes) * 60).toInt();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 159, 200, 219),
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Session Summary",
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total Time: ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} minutes',
                style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 10, 44, 71)),
              ),
              const SizedBox(height: 10),
              Text(
                'Phases Completed: ${widget.phasesCompleted}',
                style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 10, 44, 71)),
              ),
              const SizedBox(height: 20),
              Text(
                'Rate Your Experience',
                style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 10, 44, 71)),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      Icons.star,
                      color: index < _rating ? Color.fromARGB(255, 200, 183, 35) : Color.fromARGB(255, 255, 253, 236),
                    ),
                    onPressed: () {
                      setState(() {
                        _rating = index + 1;
                      });
                      _saveRating(index + 1);
                    },
                  );
                }),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:Color.fromARGB(255, 10, 44, 71),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst); // Return to HomeScreen directly
                },
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
