import 'package:education/templates/middleAssignment/providers/selectedSessionProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionOverviewWidget extends ConsumerStatefulWidget {
  const SessionOverviewWidget({super.key});

  @override
  ConsumerState<SessionOverviewWidget> createState() => _SessionOverviewWidgetState();
}

class _SessionOverviewWidgetState extends ConsumerState<SessionOverviewWidget> {
  @override
  Widget build(BuildContext context) {
    final selectedSession = ref.watch(selectedSessionNotifierProvider);
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    selectedSession.info(),
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/session');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[400],
                  foregroundColor: Colors.yellow[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text("Start session"),
              ),
            ],
          ),
        ),
      );
  }
}