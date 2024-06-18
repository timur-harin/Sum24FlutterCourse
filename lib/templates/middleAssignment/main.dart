import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'shower_history_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: MainScreen(),
      ),
    ),
  );
}

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contrast Shower Companion'),
      ),
      body: const ShowerHistoryScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewSessionSettingsScreen()),
          );
        },
        child: SvgPicture.asset('assets/svg/shower.svg'),
      ),
    );
  }
}

class ShowerSession {
  final Duration duration;
  final Duration temperatureInterval;
  final List<Duration> intervals; // Add this line

  ShowerSession({
    required this.duration,
    required this.temperatureInterval,
    this.intervals = const [], // Add this line
  });
}

class NewSessionSettingsScreen extends StatefulWidget {
  const NewSessionSettingsScreen({super.key});

  @override
  _NewSessionSettingsScreenState createState() => _NewSessionSettingsScreenState();
}

class ShowerHistory extends StateNotifier<List<ShowerSession>> {
  ShowerHistory() : super([]);

  void add(ShowerSession session) {
    state = [...state, session];
  }
}

class _NewSessionSettingsScreenState extends State<NewSessionSettingsScreen> {
  final showerHistoryProvider = StateNotifierProvider<ShowerHistory, List<ShowerSession>>((ref) => ShowerHistory());
  final _formKey = GlobalKey<FormState>();
  int _duration = 0;
  int _temperatureInterval = 0;
  ShowerSession currentSession = ShowerSession(duration: Duration.zero, temperatureInterval: Duration.zero);
  void addInterval() {
    // Создайте новый интервал
    final newInterval = Duration(minutes: 1); // Замените это на желаемую продолжительность

    // Добавьте новый интервал в текущую сессию
    setState(() {
      // Предполагается, что у вас есть ссылка на текущую сессию
      currentSession.intervals.add(newInterval);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Session Settings'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Duration',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a duration';
                }
                return null;
              },
              onSaved: (value) {
                _duration = int.parse(value!);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Temperature Interval',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a temperature interval';
                }
                return null;
              },
              onSaved: (value) {
                _temperatureInterval = int.parse(value!);
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  // Create a new ShowerSession with the input data
                  final newSession = ShowerSession(
                    duration: Duration(minutes: _duration),
                    temperatureInterval: Duration(minutes: _temperatureInterval),
                  );

                  // Add the new session to the shower history
                  final container = ProviderContainer();
                  final showerHistoryNotifier = container.read(showerHistoryProvider.notifier);
                  showerHistoryNotifier.add(newSession);
                  // Navigate back to the previous screen
                  Navigator.pop(context);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addInterval,
        child: Icon(Icons.add),
        tooltip: 'Add new interval',
      ),
    );

  }
}

