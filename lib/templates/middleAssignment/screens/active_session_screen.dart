import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/temperature_phase.dart';
import '../providers/session_provider.dart';
import '../widgets/custom_render_object.dart';

class ActiveSessionScreen extends ConsumerStatefulWidget {
  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends ConsumerState<ActiveSessionScreen> {
  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Active Session'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomRenderObject(session.currentPhase ?? TemperaturePhase.cold),
          SizedBox(height: 20),
          Text(
            '${session.remainingTime} seconds',
            style: TextStyle(fontSize: 48),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ref.read(sessionProvider.notifier).pauseSession();
            },
            child: Text('Pause'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(sessionProvider.notifier).endSession();
              Navigator.pop(context);
            },
            child: Text('End Session'),
          ),
        ],
      ),
    );
  }
}
