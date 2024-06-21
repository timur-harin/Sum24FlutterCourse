import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ShowerSessionAdapter());
  await Hive.openBox<ShowerSession>('sessionBox');

  runApp(const ProviderScope(child: MiddleAssignmentApp()));
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
          color: Colors.blue,
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
        title: const Text(
          'Contrast Shower Companion',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: Hive.openBox<ShowerSession>('sessionBox'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Error loading session history'));
            } else {
              var box = Hive.box<ShowerSession>('sessionBox');
              return ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, Box<ShowerSession> box, _) {
                  if (box.values.isEmpty) {
                    return Center(child: Text('No sessions found'));
                  } else {
                    return ListView.builder(
                      itemCount: box.values.length,
                      itemBuilder: (context, index) {
                        ShowerSession session = box.getAt(index)!;
                        return ListTile(
                          title: Text('Session ${index + 1}'),
                          subtitle: Text('Started at: ${session.startTime}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PostSessionScreen(session: session)),
                            );
                          },
                        );
                      },
                    );
                  }
                },
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SessionPreferencesScreen()),
          );
        },
        child: Text('Start New Session'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}

class SessionPreferencesScreen extends ConsumerStatefulWidget {
  @override
  _SessionPreferencesScreenState createState() => _SessionPreferencesScreenState();
}

class _SessionPreferencesScreenState extends ConsumerState<SessionPreferencesScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _hotDurationController;
  late TextEditingController _coldDurationController;
  late TextEditingController _overallTimeController;

  @override
  void initState() {
    super.initState();
    _hotDurationController = TextEditingController(text: '60');
    _coldDurationController = TextEditingController(text: '60');
    _overallTimeController = TextEditingController(text: '300');
  }

  @override
  void dispose() {
    _hotDurationController.dispose();
    _coldDurationController.dispose();
    _overallTimeController.dispose();
    super.dispose();
  }

  void _savePreferences() {
    if (_formKey.currentState!.validate()) {
      final hotDuration = Duration(seconds: int.parse(_hotDurationController.text));
      final coldDuration = Duration(seconds: int.parse(_coldDurationController.text));
      final overallTime = Duration(seconds: int.parse(_overallTimeController.text));
      ref.read(userPreferencesProvider.notifier).updatePreferences(hotDuration, coldDuration, overallTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Session Preferences',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _overallTimeController,
                decoration: InputDecoration(labelText: 'Overall time (seconds)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _hotDurationController,
                decoration: InputDecoration(labelText: 'Hot Duration (seconds)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _coldDurationController,
                decoration: InputDecoration(labelText: 'Cold Duration (seconds)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _savePreferences();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ActiveSessionScreen()),
                  );
                },
                child: Text('Begin Session'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActiveSessionScreen extends ConsumerStatefulWidget {
  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends ConsumerState<ActiveSessionScreen> {
  late int _remainingTime;
  late int _timeLeft;
  late bool _isHotPhase;
  late Duration _hotDuration;
  late Duration _coldDuration;
  late Duration _overallTime;
  late List<TemperaturePhase> _phases;
  late DateTime _startTime;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    final userPreferences = ref.read(userPreferencesProvider);
    _hotDuration = userPreferences.hotDuration;
    _coldDuration = userPreferences.coldDuration;
    _overallTime = userPreferences.overallTime;
    _isHotPhase = true;
    _remainingTime = _hotDuration.inSeconds;
    _timeLeft = _overallTime.inSeconds;
    _phases = [];
    _startTime = DateTime.now();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (_isPaused) return;
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _endSession();
        return;
      }
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
      _phases.add(TemperaturePhase(isHot: _isHotPhase, duration: Duration(seconds: _isHotPhase ? _hotDuration.inSeconds - _remainingTime : _coldDuration.inSeconds - _remainingTime)));
      _isHotPhase = !_isHotPhase;
      _remainingTime = _isHotPhase ? _hotDuration.inSeconds : _coldDuration.inSeconds;
    });
    _startTimer();
  }

  void _endSession() async {
    _phases.add(TemperaturePhase(
      isHot: _isHotPhase,
      duration: Duration(seconds: _isHotPhase ? _hotDuration.inSeconds - _remainingTime : _coldDuration.inSeconds - _remainingTime),
    ));
    ShowerSession session = ShowerSession(startTime: _startTime, phases: _phases);
    
    // Save session details to Hive
    var box = Hive.box<ShowerSession>('sessionBox');
    await box.add(session);
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PostSessionScreen(session: session)),
    );
  }

  void _pauseTimer() {
    setState(() {
      _isPaused = !_isPaused;
    });
    if (!_isPaused) {
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Active Session',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Time left: $_timeLeft seconds',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 125),
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
            PhaseTransitionWidget(isHotPhase: _isHotPhase),
            SizedBox(height: 175),
            ElevatedButton(
              onPressed: _pauseTimer,
              child: Text(_isPaused ? 'Resume' : 'Pause'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _endSession,
              child: Text('End Session'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class PhaseTransitionWidget extends StatefulWidget {
  final bool isHotPhase;

  const PhaseTransitionWidget({Key? key, required this.isHotPhase}) : super(key: key);

  @override
  _PhaseTransitionWidgetState createState() => _PhaseTransitionWidgetState();
}

class _PhaseTransitionWidgetState extends State<PhaseTransitionWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: widget.isHotPhase ? [Colors.red, Colors.red[200]!] : [Colors.blue, Colors.blue[200]!],
              stops: [0.5, _controller.value],
            ),
          ),
        );
      },
    );
  }
}

class ShowerSession {
  final DateTime startTime;
  final List<TemperaturePhase> phases;

  ShowerSession({required this.startTime, required this.phases});
}

class TemperaturePhase {
  final bool isHot;
  final Duration duration;

  TemperaturePhase({required this.isHot, required this.duration});
}


class UserPreferences {
  final Duration hotDuration;
  final Duration coldDuration;
  final Duration overallTime;

  UserPreferences({required this.hotDuration, required this.coldDuration, required this.overallTime});
}

final userPreferencesProvider = StateNotifierProvider<UserPreferencesNotifier, UserPreferences>((ref) {
  return UserPreferencesNotifier();
});

class UserPreferencesNotifier extends StateNotifier<UserPreferences> {
  UserPreferencesNotifier()
      : super(UserPreferences(hotDuration: Duration(seconds: 60), coldDuration: Duration(seconds: 60), overallTime: Duration(seconds: 300)));

  void updatePreferences(Duration hotDuration, Duration coldDuration, Duration overallTime) {
    state = UserPreferences(hotDuration: hotDuration, coldDuration: coldDuration, overallTime: overallTime);
  }
}

final sessionHistoryProvider = StateNotifierProvider<SessionHistoryNotifier, List<ShowerSession>>((ref) {
  return SessionHistoryNotifier();
});

class SessionHistoryNotifier extends StateNotifier<List<ShowerSession>> {
  SessionHistoryNotifier() : super([]);

  void addSession(ShowerSession session) {
    state = [...state, session];
  }
}

class ShowerSessionAdapter extends TypeAdapter<ShowerSession> {
  @override
  final typeId = 0;

  @override
  ShowerSession read(BinaryReader reader) {
    final startTime = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final phases = (reader.readList() as List)
        .map((e) => TemperaturePhase(isHot: e['isHot'], duration: Duration(seconds: e['duration'])))
        .toList();
    return ShowerSession(startTime: startTime, phases: phases);
  }

  @override
  void write(BinaryWriter writer, ShowerSession obj) {
    writer.writeInt(obj.startTime.millisecondsSinceEpoch);
    writer.writeList(obj.phases.map((e) => {'isHot': e.isHot, 'duration': e.duration.inSeconds}).toList());
  }
}


class PostSessionScreen extends StatelessWidget {
  final ShowerSession session;

  PostSessionScreen({required this.session});

  @override
  Widget build(BuildContext context) {
    final overallTime = session.phases.fold(
      Duration.zero,
      (sum, phase) => sum + phase.duration,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Session Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Session Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Start Time: ${session.startTime}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Overall Time: ${overallTime.inMinutes} minutes ${overallTime.inSeconds % 60} seconds',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Temperature Phases:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: session.phases.length,
                itemBuilder: (context, index) {
                  final phase = session.phases[index];
                  return ListTile(
                    title: Text('${phase.isHot ? 'Hot' : 'Cold'} Phase'),
                    subtitle: Text(
                      '${phase.duration.inMinutes} minutes ${phase.duration.inSeconds % 60} seconds',
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Rate Your Experience:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            RatingWidget(),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text('Go Home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class RatingWidget extends StatefulWidget {
  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
          onPressed: () {
            setState(() {
              _rating = index + 1;
            });
            _saveRating(_rating);
          },
        );
      }),
    );
  }

  void _saveRating(int rating) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_session_rating', rating);
  }
}