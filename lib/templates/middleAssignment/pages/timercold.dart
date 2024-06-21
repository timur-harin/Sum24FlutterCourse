// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:midterm/pages/riverpod.dart';
// import '../widgets/round-button.dart';
// import 'package:midterm/pages/timer.dart';
// // import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

// class TimerScreenCold extends ConsumerStatefulWidget {
//   int times;
//   TimerScreenCold({Key? key,required this.times}) : super(key: key);
//   @override
//   TimerScreenColdState createState() => TimerScreenColdState(times:times);
// }

// class TimerScreenColdState extends ConsumerState<TimerScreenCold>
//     with TickerProviderStateMixin {
//     int times;
//     TimerScreenColdState({required this.times});
//     late AnimationController controller;

//   bool isPlaying = false;

//   String get countText {
//     Duration count = controller.duration! * controller.value;
//     return controller.isDismissed
//         ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
//         : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
//   }

//   double progress = 1.0;

//   void notify() {
//   print(ref.read(riverpod_times));
//     if (countText == '0:00:00') {
//       if (times > 1) {
//         Future.delayed(Duration(seconds: 1), () {
//           Navigator.push(context, MaterialPageRoute(builder: (context) => TimerScreen(times: times--)));
//         });
//       } else {
//         Navigator.pushNamed(context, '/end');
//       }// FlutterRingtonePlayer.playNotification();
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: ref.read(riverpod_cold)),
//     );

//     Future.delayed(Duration(seconds: 1), () {
//         controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);
//     });
//     controller.addListener(() {
//       notify();
//       if (controller.isAnimating) {
//         setState(() {
//           progress = controller.value;
//         });
//       } else {
//         setState(() {
//           progress = 1.0;
//           isPlaying = false;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff1241cd),
//       body: Column(
//         children: [
//           Expanded(
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 SizedBox(
//                   width: 300,
//                   height: 300,
//                   child: CircularProgressIndicator(
//                     backgroundColor: Color(0xffACDFFE),
//                     value: progress,
//                     strokeWidth: 6,
//                     valueColor: AlwaysStoppedAnimation<Color>(Color(0xff1241cd)),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     if (controller.isDismissed) {
//                       showModalBottomSheet(
//                         context: context,
//                         builder: (context) => Container(
//                           height: 300,
//                           child: CupertinoTimerPicker(
//                             initialTimerDuration: controller.duration!,
//                             onTimerDurationChanged: (time) {
//                               setState(() {
//                                 controller.duration = time;
//                               });
//                             },
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                   child: AnimatedBuilder(
//                     animation: controller,
//                     builder: (context, child) => Text(
//                       countText,
//                       style: TextStyle(
//                         fontSize: 60,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xffACDFFE)
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     controller.reset();
//                     setState(() {
//                       isPlaying = false;
//                     });
//                     Navigator.pushNamed(context, '/end');
//                   },
//                   child: RoundButton(
//                     icon: Icons.stop,
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  bool _isHot = false;
  Timer? _timer;
  int _timer1Duration = 2; // Initial duration for timer1 in seconds
  int _timer2Duration = 4; // Initial duration for timer2 in seconds
  String _timer1Text = "Timer 1: 2 seconds";
  String _timer2Text = "Timer 2: 4 seconds";
  bool _isTimer1 = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();

    int duration = _isTimer1 ? _timer1Duration : _timer2Duration;
    _timer = Timer(Duration(seconds: duration), () {
      setState(() {
        _isHot = !_isHot;
        if (_isTimer1) {
          _timer1Text = "Timer 1: $_timer1Duration seconds (completed)";
          _timer1Duration = _timer1Duration == 2 ? 4 : 2;
        } else {
          _timer2Text = "Timer 2: $_timer2Duration seconds (completed)";
          _timer2Duration = _timer2Duration == 4 ? 2 : 4;
        }
        _isTimer1 = !_isTimer1;
        _startTimer();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Interchanging Timers"),
      ),
      backgroundColor: _isHot ? Colors.red : Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _timer1Text,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              _timer2Text,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}