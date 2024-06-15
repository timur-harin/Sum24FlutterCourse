import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_render_object.dart';
import '../data/providers/session_provider.dart';

// class ActiveSessionScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final session = context.watch<SessionProvider>().currentSession;
//
//     if (session == null) {
//       // Handle the case where the session is null, e.g. by navigating back to the home screen
//       return Scaffold(
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text('Back to Home'),
//           ),
//         ),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Active Session'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Current Phase: ${session?.phases[0].temperature}°C'),
//             Text('Remaining Time: ${session!.duration ~/ 60} minutes'),
//             ElevatedButton(
//               onPressed: () {
//                 context.read<SessionProvider>().endSession();
//                 Navigator.pop(context);
//               },
//               child: Text('End Session'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


class ActiveSessionScreen extends StatefulWidget {
  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> {
  Timer? _timer;
  int _sessionPhase = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      context.read<SessionProvider>().updateRemainingTime();
      if (_sessionPhase == 0) { _sessionPhase = 1;} else {_sessionPhase = 0;}
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionProvider>().currentSession;

    if (session == null) {
      // Handle the case where the session is null, e.g. by navigating back to the home screen
      return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Back to Home'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Active Session'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TemperaturePhaseIndicator(temperature: session.phases[_sessionPhase].temperature),
            SizedBox(height: 20),
            Text('Remaining Time: ${session.remainingTime} minutes'),

            ElevatedButton(
              onPressed: () {
                context.read<SessionProvider>().endSession();
                Navigator.pop(context);
              },
              child: Text('End Session'),
            ),
          ],
        ),
      ),
    );
  }


}


