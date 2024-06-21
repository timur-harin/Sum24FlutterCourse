import 'package:education/templates/middleAssignment/data/models/shower_history.dart';
import 'package:education/templates/middleAssignment/ui/pages/while_session.dart';
import 'package:flutter/material.dart';
import 'package:education/templates/middleAssignment/providers/notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowerHistoryScreen extends StatelessWidget {
  const ShowerHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Shower History"),
          centerTitle: true,
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: const SingleChildScrollView(child: ShowerHistoryWidget()));
  }
}

class ShowerHistoryWidget extends ConsumerStatefulWidget {
  const ShowerHistoryWidget({super.key});

  @override
  ConsumerState<ShowerHistoryWidget> createState() => _ShowerSessionWidgetState();
}

class _ShowerSessionWidgetState extends ConsumerState<ShowerHistoryWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sessions = ref.watch(showerSessionsProvider);

    return Align(
      alignment: Alignment.center,
      child: Column(children: sessions.map((session) => ShowerWidget(session: session)).toList()),
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
                .map((phase) => Text('${phase.temperature} water for ${phase.duration} seconds',
                    style: const TextStyle(
                      fontSize: 16,
                    ))),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                ref.read(showerSessionsProvider.notifier).removeSession(session.id);
                Navigator.pop(context);
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WhileSessionWidget(session: session)));
              },
              child: const Text('Start Session',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
