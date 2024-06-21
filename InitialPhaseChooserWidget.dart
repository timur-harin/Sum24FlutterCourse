import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Providers.dart';
import 'Constants.dart';

class InitialPhaseChooserWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InitialPhaseChooserWidget();
}

class _InitialPhaseChooserWidget extends ConsumerState<InitialPhaseChooserWidget> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(initialPhaseProvider);
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: ListTile(
            title: const Text("Start with cold phase"),
            leading: Radio<String>(
              value: defaultInitialPhase,
              groupValue: notifier,
              onChanged: (String? initialPhase) {
                ref.watch(initialPhaseProvider.notifier).setInitialShowerSessionPhase(initialPhase ?? defaultInitialPhase);
              },
            ),
          )),
          Expanded(child: ListTile(
            title: const Text("Start with hot phase"),
            leading: Radio<String>(
              value: "hot",
              groupValue: notifier,
              onChanged: (String? initialPhase) {
                ref.watch(initialPhaseProvider.notifier).setInitialShowerSessionPhase(initialPhase ?? defaultInitialPhase);
              },
            ),
          ))
        ]
    );
  }
}