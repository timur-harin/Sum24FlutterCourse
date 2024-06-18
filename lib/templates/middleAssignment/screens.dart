import 'dart:math';
import 'package:education/templates/middleAssignment/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets.dart';


class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = ref.watch(showerSessionsProvider).sessions;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contrast Shower"),
      ),

      body: Container(
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       Color(0xFF3366FF),
        //       Color(0xFF00CCFF),
        //     ],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     stops: [0.0, 1.0],
        //   )
        // ),

        child: const Center(
            child: ShowerSessionList()
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Start new session"),
        icon: const Icon(Icons.add),
        onPressed: () => {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const MainScreen())
          )

          // ref
          //     .read(showerSessionsProvider.notifier)
          //     .addSession()
        },
      ),
    );
  }
}


class NewSessionSettingsScreen extends ConsumerWidget {
  const NewSessionSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(

    );
  }
}

class ShowerSessionScreen extends ConsumerWidget {
  const ShowerSessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(

    );
  }
}


class ShowerSessionOverviewScreen extends ConsumerWidget {
  const ShowerSessionOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(

    );
  }
}