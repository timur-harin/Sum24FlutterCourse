import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:education/templates/middleAssignment/home_page_widget.dart';
import 'package:education/templates/middleAssignment/session_overview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'counter_provider.dart';

const int STEP = 5;

class CounterPage extends ConsumerWidget {
  const CounterPage({Key? key}) : super(key: key);

  void _startSession(BuildContext context, List<int> durations) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => TimerSessionPage(
            durations: durations
        ),
      ),
          (Route<dynamic> route) => false,
    ).then((sessionDuration) {
        if (sessionDuration != null) {
          _addSessionToSharedPreferences(sessionDuration);
        }
      }
    );
  }

  Future<void> _addSessionToSharedPreferences(int sessionDuration) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> sessions = prefs.getStringList('sessions') ?? [];
    sessions.add('Session duration: $sessionDuration seconds');
    await prefs.setStringList('sessions', sessions);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counters = ref.watch(countersProvider);
    final countersNotifier = ref.read(countersProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        title: Text(
          'ContrastApp',
          style: GoogleFonts.getFont(
            'Lexend',
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),

      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: counters.length + 1,
                    itemBuilder: (context, index) {
                      if (index == counters.length) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            height: 80,
                            child: Center(
                              child: ElevatedButton(
                                onPressed: countersNotifier.addCounter,
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.fromHeight(80),
                                  backgroundColor: Colors.greenAccent.shade100,
                                ),
                                child: Text(
                                  'Add ',
                                  style: GoogleFonts.getFont(
                                    'Lexend',
                                    color: Colors.black87,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                      Color containerColor = index % 2 != 0
                          ? Colors.blue.shade100
                          : Colors.red.shade100;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: containerColor,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () => countersNotifier.decrementCounter(index),
                              ),
                              Text(
                                '${counters[index]} seconds',
                                style: GoogleFonts.getFont(
                                  'Lexend',
                                  color: Colors.black87,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => countersNotifier.incrementCounter(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 64, // Adjust the height as needed
          child: ElevatedButton(
            onPressed: () => _startSession(context, counters),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent.shade100,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16), // Adjust top radius as needed
                ),
              ),
            ),
            child: Text(
              'Start',
              textAlign: TextAlign.center,
              style: GoogleFonts.getFont(
                'Lexend',
                color: Colors.white,
                fontSize: 32,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


void playSound() async {
  final player = AudioPlayer();
  await player.play("assets/sound.mp3");
}

class TimerSessionPage extends StatefulWidget {
  final List<int> durations;

  TimerSessionPage({Key? key, required this.durations}) : super(key: key);

  @override
  _TimerSessionPageState createState() => _TimerSessionPageState();
}

class _TimerSessionPageState extends State<TimerSessionPage> {
  int _currentTimerIndex = 0;
  bool _isSessionActive = true;
  bool _isTimerPaused = false;
  late Color _currentBackgroundColor;
  late List<Color> _backgroundColors;
  late int _totalDuration;
  late Timer _timer;
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();
    _currentBackgroundColor = Colors.blue.shade100;
    _backgroundColors = [Colors.red.shade100, Colors.blue.shade100];
    _totalDuration = 0;

    _startNextTimer(null);
  }

  void _startNextTimer(int? remainingSeconds) {
    playSound();
    if (_currentTimerIndex < widget.durations.length) {
      int duration = widget.durations[_currentTimerIndex];
      if (remainingSeconds != null) {
        duration = remainingSeconds;
      }
      _totalDuration += duration;
      _remainingSeconds = duration;

      setState(() {
        _currentBackgroundColor = _backgroundColors[_currentTimerIndex % 2];
      });

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!_isTimerPaused) {
          setState(() {
            _remainingSeconds--;
          });
        }
        if (_remainingSeconds <= 0) {
          _timer.cancel();
          setState(() {
            _currentTimerIndex++;
          });
          _startNextTimer(null);
        }
      });
    } else {
      _endSession();
    }
  }

  void _endSession() async {
    _timer.cancel();
    setState(() {
      _isSessionActive = false;
    });

    // Calculate red and blue background times
    int redBackgroundTime = 0;
    int blueBackgroundTime = 0;
    for (int i = 0; i < widget.durations.length; i++) {
      if (i % 2 == 0) {
        blueBackgroundTime += widget.durations[i];
      } else {
        redBackgroundTime += widget.durations[i];
      }
    }

    _totalDuration = blueBackgroundTime + redBackgroundTime;
    DateTime sessionDate = DateTime.now();
    String dateString = DateFormat('d MMMM y HH:mm').format(sessionDate);
    // Save session data
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> sessions = prefs.getStringList('sessions') ?? [];
    sessions.add('Session duration: $_totalDuration seconds \n'
        'Date: $dateString\n'
        'Cold temperature time: $blueBackgroundTime seconds\n'
        'Hot temperature time: $redBackgroundTime seconds');
    await prefs.setStringList('sessions', sessions);

// Navigate to SessionOverviewPage
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => SessionOverviewPage(
          sessionData: '$_totalDuration seconds',
          redBackgroundTime: redBackgroundTime,
          blueBackgroundTime: blueBackgroundTime,
          sessionDate: dateString,
        ),
      ),
      (Route<dynamic> route) => false,
    );

    await prefs.setStringList('sessions', sessions);
  }

  void _skipCurrentTimer() {
    _timer.cancel();
    setState(() {
      _currentTimerIndex++;
    });
    _startNextTimer(null);
  }

  void _stopSession() {
    if (_isTimerPaused) {
      _endSession();
    } else {
      _timer.cancel();
      setState(() {
        _isTimerPaused = true;
      });
    }
  }

  void _continueTimer(int remainingSeconds) {
    setState(() {
      _isTimerPaused = false;
    });
    _startNextTimer(remainingSeconds);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: true,
        title: Text(
          'Contrast Shower Session',
          style: GoogleFonts.getFont(
            'Lexend',
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            color: Colors.black87,
            onPressed: () {
              // Define the action for the Home button here
              // For example, navigate to the home page
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePageWidget()),
                    (Route<dynamic> route) => false, // Removes all routes below this one
              );
            },
          ),
        ],
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        // Adjust duration as needed
        curve: Curves.easeInOut,
        // Adjust curve for smoother animation
        color: _currentBackgroundColor,
        child: Center(
          child: _isSessionActive
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Session ${_currentTimerIndex + 1} is running...',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Lexend',
                  color: Colors.black87,
                  fontSize: 24,
                ),
              ),
              Text(
                '${(_remainingSeconds ~/ 60).toString().padLeft(2, '0')}:${(_remainingSeconds % 60).toString().padLeft(2, '0')}',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Lexend',
                  color: Colors.black54,
                  fontSize: 64,
                ),
              ),
              const SizedBox(height: 20),

              // Temperature guidance text container
              if (_currentBackgroundColor == Colors.red.shade100)
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.red.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Please switch your temperature to <45°C',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont(
                      'Lexend',
                      color: Colors.black87,
                      fontSize: 18,
                    ),
                  ),
                )
              else if (_currentBackgroundColor == Colors.blue.shade100)
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Please switch your temperature to >15°C',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont(
                      'Lexend',
                      color: Colors.black87,
                      fontSize: 18,
                    ),
                  ),
                ),
              const SizedBox(height: 20),

              // Temperature difference advice container
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.orange.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Consider that the difference between temperatures should not be over 30°C',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Lexend',
                    color: Colors.black87,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Buttons for skipping or stopping session
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _skipCurrentTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Skip',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Lexend',
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _isTimerPaused ? () => _continueTimer(_remainingSeconds) : _stopSession,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isTimerPaused ? Colors.green : Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      _isTimerPaused ? 'Continue' : 'Stop',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Lexend',
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
              : const Text(
            'Session Ended!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
