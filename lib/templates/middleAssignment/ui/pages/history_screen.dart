import 'package:education/templates/middleAssignment/data/models/shower_history.dart';
import 'package:flutter/material.dart';
import 'package:education/templates/middleAssignment/providers/notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/middleAssignment/ui/pages/new_session_screen.dart';

class ShowerHistoryScreen extends StatelessWidget {
  const ShowerHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: Column(
        children: [ShowerHistoryWidget()],
      ),
    );
  }
}

class ShowerHistoryWidget extends ConsumerStatefulWidget {
  const ShowerHistoryWidget({super.key});

  @override
  ConsumerState<ShowerHistoryWidget> createState() => _ShowerSessionWidgetState();
}

class _ShowerSessionWidgetState extends ConsumerState<ShowerHistoryWidget> {
  ShowerSession? session;

  @override
  void initState() {
    session = ShowerSession(id: 5, date: "2024-01-01 12:00", temperaturePhases: [
      TemperaturePhase(id: 1, temperature: "hot", duration: 30),
      TemperaturePhase(id: 2, temperature: "cold", duration: 30),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sessions = ref.watch(showerSessionsProvider);

    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
                children: sessions.map((session) => ShowerWidget(session: session)).toList()),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NewShowerSessionWidget()));
              setState(() {
                ref.read(showerSessionsProvider.notifier).addSession(session!);
              });
            },
            child: const Text("Add Session"),
          ),
        ),
      ],
    );
  }
}

class ShowerWidget extends StatelessWidget {
  final ShowerSession session;

  const ShowerWidget({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ShowerDetailsScreen(session: session)));
      },
      child: ListTile(
        leading: const Icon(Icons.add_alarm_rounded),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shower ${session.id}'),
          ],
        ),
        subtitle: Text('On ${session.date} with ${session.temperaturePhases.length} phases'),
      ),
    );
  }
}

class ShowerDetailsScreen extends ConsumerWidget {
  final ShowerSession session;

  const ShowerDetailsScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shower Details'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Date: ${session.date}', style: const TextStyle(fontSize: 18)),
            const Text('Temperature Phases:', style: TextStyle(fontSize: 16)),
            ...session.temperaturePhases
                .map((phase) => Text('${phase.temperature}°C for ${phase.duration} minutes')),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                ref.read(showerSessionsProvider.notifier).removeSession(session.id);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}


