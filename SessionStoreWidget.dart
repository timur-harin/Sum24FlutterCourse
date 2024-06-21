import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Providers.dart';
import 'Constants.dart';

class SessionStoreWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SessionStoreWidget();
}

class _SessionStoreWidget extends ConsumerState<SessionStoreWidget> {
  @override
  Widget build(BuildContext context) {
    final showerSessionHistory = ref.watch(sharedPrefsProvider);
    if (showerSessionHistory.isEmpty) {
      return const Text("There is no any shower session");
    }
    return Flexible(
      fit: FlexFit.tight,
      child: FractionallySizedBox(
        heightFactor: defaultContainerFraction,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.green,
                  width: 1
              )
          ),
          child: SingleChildScrollView(
              child: Column(
                  children: showerSessionHistory.map((item) => Text("Number $item")).toList()
              )
          ),
        ),
      ),
    );
  }
}
