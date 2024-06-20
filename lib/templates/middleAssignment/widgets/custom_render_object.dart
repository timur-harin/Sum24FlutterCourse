import 'package:education/templates/middleAssignment/providers/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:education/templates/middleAssignment/models/temperature_phase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class PhaseWidget extends StatelessWidget {
//   final TemperaturePhase currentPhase;
//   final int time;

//   PhaseWidget({required this.currentPhase, required this.time});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: Duration(seconds: 1),
//       color: currentPhase == TemperaturePhase.pause ? Colors.red : Colors.blue,
//       child: Center(
//         child: Text(
//           "${time}",
//           style: TextStyle(fontSize: 24, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }


class PhaseWidget extends ConsumerStatefulWidget {
  final int time; 
  final int cycles_left;
  final int cycles_done;

  PhaseWidget({required this.time, required this.cycles_left, required this.cycles_done,Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PhaseWidgetState();
}

class _PhaseWidgetState extends ConsumerState<PhaseWidget> {
  

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      color:  ref.read(sessionRiverpod.notifier).lastPhase == TemperaturePhase.hot ? Colors.red : Colors.blue,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("${widget.time}", style: const TextStyle(fontSize: 24, color: Colors.white), textAlign: TextAlign.center),
            SizedBox(height: screenSize.height/3),
            Text("Cycles done:${widget.cycles_done}", style: const TextStyle(fontSize: 24, color: Colors.white)),
            Text("Cycles left:${widget.cycles_left}", style: const TextStyle(fontSize: 24, color: Colors.white)),
          ]
        ),
      ),
      alignment: Alignment.center,
      height: screenSize.height/2,
      width: screenSize.width,
    );
  }
}


