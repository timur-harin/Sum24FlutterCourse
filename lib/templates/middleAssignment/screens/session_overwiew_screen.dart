

import 'package:education/templates/middleAssignment/providers/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionOverwiewScreen extends ConsumerStatefulWidget{

  const SessionOverwiewScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SessionOverwiewScreenState();

}

class _SessionOverwiewScreenState extends ConsumerState<SessionOverwiewScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Overview'),
      ),
      body: Center(
        child: Column(
          children:  [
            Text('Total Duration: ${ref.watch(preferencesProvider).numberOfPhases * ref.watch(preferencesProvider).phaseDuration}'),
            Text("Number of Phases: ${ref.watch(preferencesProvider).numberOfPhases}"),
            Text("Phase Duration: ${ref.watch(preferencesProvider).phaseDuration}"), 
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/session');
              },
              child: Text("Start session"),
            )
          ]
        ),
      ),
    );
  }

}