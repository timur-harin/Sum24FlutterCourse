import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'active_session_screen.dart';
import 'shower_session.dart';
import 'session_history_provider.dart';
import 'theme.dart';

class SessionScreen extends ConsumerStatefulWidget {
  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen> {
  final _totalDurationController = TextEditingController();
  final _hotDurationController = TextEditingController();
  final _coldDurationController = TextEditingController();
  final _hotTemperatureController = TextEditingController();
  final _coldTemperatureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'New Session',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField('Total Duration (minutes)', _totalDurationController),
            _buildTextField('Hot Duration (seconds)', _hotDurationController),
            _buildTextField('Cold Duration (seconds)', _coldDurationController),
            _buildTextField('Hot Temperature (°C)', _hotTemperatureController),
            _buildTextField('Cold Temperature (°C)', _coldTemperatureController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startSession,
              child: Text('Start Session'),
            ),
          ],
        ),
      ),
    );
  }

  TextField _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
    );
  }

  void _startSession() {
    final totalDuration = int.tryParse(_totalDurationController.text) ?? 0;
    final hotDuration = int.tryParse(_hotDurationController.text) ?? 0;
    final coldDuration = int.tryParse(_coldDurationController.text) ?? 0;
    final hotTemperature = int.tryParse(_hotTemperatureController.text) ?? 0;
    final coldTemperature = int.tryParse(_coldTemperatureController.text) ?? 0;

    final session = ShowerSession(
      date: DateTime.now(),
      totalDuration: totalDuration,
      hotDuration: hotDuration,
      coldDuration: coldDuration,
      hotTemperature: hotTemperature,
      coldTemperature: coldTemperature,
      cycles: List.generate(
        totalDuration * 60 ~/ (hotDuration + coldDuration),
            (index) => ShowerCycle(hotDuration: hotDuration, coldDuration: coldDuration),
      ),
    );

    ref.read(sessionHistoryProvider.notifier).addSession(session);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ActiveSessionScreen(
        session: session,
        currentCycle: 0,
        isHot: true,
      )),
    );
  }
}
