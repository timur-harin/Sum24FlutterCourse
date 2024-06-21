import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Constants.dart';
import 'Providers.dart';
import 'MainAppBarFlexibleSpace.dart';
import 'InitialPhaseChooserWidget.dart';
import 'InvalidSessionPreferencesDialog.dart';
import 'ShowerSessionDuration.dart';

class InputeShowerSessionPreferences extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InputeShowerSessionPreferences();
}

class _InputeShowerSessionPreferences extends ConsumerState<InputeShowerSessionPreferences> {
  final _coldPhaseTextControllerForMinutes = TextEditingController();
  final _coldPhaseTextControllerForSeconds = TextEditingController();
  final _hotPhaseTextControllerForMinutes = TextEditingController();
  final _hotPhaseTextControllerForSeconds = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Start new shower session"),
          flexibleSpace: MainAppBarFlexibleSpace(),
          automaticallyImplyLeading: false,
        ),
        body: SizedBox.expand(
          child: FractionallySizedBox(
              widthFactor: defaultContainerFraction,
              heightFactor: defaultContainerFraction,
              alignment: FractionalOffset.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _coldPhaseTextControllerForMinutes,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "How many minutes will the cold phase take?"
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _coldPhaseTextControllerForSeconds,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "How many seconds will the cold phase take?"
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _hotPhaseTextControllerForMinutes,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "How many minutes will the hot phase take?"
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _hotPhaseTextControllerForSeconds,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "How many seconds will the hot phase take?"
                          ),
                        ),
                      )
                    ],
                  ),
                  InitialPhaseChooserWidget(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Back"),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              final minutesCold = int.tryParse(_coldPhaseTextControllerForMinutes.text);
                              final secondsCold = ShowerSessionDuration.getSeconds(_coldPhaseTextControllerForSeconds.text);
                              final minutesHot = int.tryParse(_hotPhaseTextControllerForMinutes.text);
                              final secondsHot = ShowerSessionDuration.getSeconds(_hotPhaseTextControllerForSeconds.text);
                              final initialPhase = ref.watch(initialPhaseProvider);
                              if (minutesCold == null || secondsCold == null ||
                                  minutesHot == null || secondsHot == null) {
                                showDialog(
                                    context: context,
                                    builder: (context) => const InvalidSessionPreferencesDialog(
                                      dialogText: "Specify the duration of the cold and hot shower phases",
                                    )
                                );
                              } else {
                                ref.watch(showerSessionPrefsProvider.notifier).setShowerSessionPrefs(
                                    initialPhase, minutesCold * 60 + secondsCold, minutesHot * 60 + secondsHot
                                );
                                if (initialPhase == "cold") {
                                  Navigator.of(context).pushNamed("/coldPhasePage", arguments: {
                                        "movesLeft" : 2 }
                                  );
                                } else {
                                  Navigator.of(context).pushNamed("/hotPhasePage", arguments: {
                                    "movesLeft" : 2 }
                                  );
                                }
                              }
                            },
                            child: const Text("Start")
                        )
                      ]
                  )
                ],
              )
          ),
        )
    );
  }
}
