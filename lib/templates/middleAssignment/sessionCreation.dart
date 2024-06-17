import 'package:education/templates/middleAssignment/clocks.dart';
import 'package:education/templates/middleAssignment/notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionCreation extends ConsumerWidget {
  const SessionCreation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(SessionProvider);
<<<<<<< HEAD
    return Clocks(
        time: sessions.duration.last,
        phase: sessions.phase_duration.last,
        onIncrement: ref.read(SessionProvider.notifier).increment,
        prevent: () {
          sessions.duration.removeLast();
          sessions.phase_duration.removeLast();
          sessions.timeStart.removeLast();
        });
=======

    return Clocks(
      time: sessions.duration.last,
      onIncrement: ref.read(SessionProvider.notifier).increment,
    );
>>>>>>> eef26d5 (mid assigment commit 1)
  }
}
