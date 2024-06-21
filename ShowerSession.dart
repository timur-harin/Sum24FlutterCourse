// import 'package:flutter/material.dart';
// import 'ShowerSessionTimer.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'Providers.dart';
//
// class ShowerSession extends ConsumerStatefulWidget {
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _ShowerSession();
// }
//
// class _ShowerSession extends ConsumerState<ShowerSession> {
//   @override
//   Widget build(BuildContext context) {
//     final sessionPrefs = ref.watch(showerSessionPrefsProvider);
//     if (sessionPrefs == null) {
//       throw Exception("Unexpected session preferences");
//     }
//     final phase = sessionPrefs.firstPhase;
//     int duration = 0;
//     if (phase == "cold") {
//       duration += sessionPrefs.coldPhaseDuration;
//     } else {
//       duration += sessionPrefs.hotPhaseDuration;
//     }
//     return Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ShowerSessionTimer(duration ~/ 60, duration % 60),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pushNamedAndRemoveUntil("/home", (_) => false);
//                 },
//                 child: const Text("End session")
//             )
//           ],
//         ),
//     );
//   }
// }
