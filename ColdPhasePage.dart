import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'ShowerSessionTimer.dart';
import 'Constants.dart';
import 'Providers.dart';

class ColdPhasePage extends ConsumerStatefulWidget {
  const ColdPhasePage(this.movesLeft, {super.key});
  final int movesLeft;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ColdPhasePage(movesLeft);
}

class _ColdPhasePage extends ConsumerState<ColdPhasePage> {
  _ColdPhasePage(this.movesLeft);
  final int movesLeft;

  @override
  Widget build(BuildContext context) {
    final sessionPrefs = ref.watch(showerSessionPrefsProvider);
    if (sessionPrefs == null) {
      throw Exception("Unexpected session preferences");
    }
    final phase = sessionPrefs.firstPhase;
    final duration = sessionPrefs.coldPhaseDuration;
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      body: SizedBox.expand(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          heightFactor: 0.5,
          alignment: FractionalOffset.center,
          child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ShowerSessionTimer(duration ~/ 60, duration % 60, "/hotPhasePage", movesLeft - 1),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil("/home", (_) => false);
                    },
                    child: const Text("End session")
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}


