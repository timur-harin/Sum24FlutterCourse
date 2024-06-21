import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/middleAssignment/pages/riverpod.dart';
import '../widgets/outlinedButton.dart';
import 'dart:async';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class TimerScreen extends ConsumerStatefulWidget {
  TimerScreen({Key? key}) : super(key: key);
  @override
  TimerScreenState createState() => TimerScreenState();
}

class TimerScreenState extends ConsumerState<TimerScreen>
    with TickerProviderStateMixin {
  Timer? _timer;
  bool isPlaying = false;
  FlutterRingtonePlayer _ringtonePlayer = FlutterRingtonePlayer();

  late AnimationController controller;

  bool _isCold = false;
  bool _end = false;

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  double progress = 1.0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    if (_end) {
      Navigator.pushNamed(context, '/end');
      return;
    }
    int duration = (_isCold
        ? ref.read(riverpod_cold).round()
        : ref.read(riverpod_hot).round());
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: duration),
    );
    controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);
    controller.addListener(() {
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
          isPlaying = false;
        });
      }
    });

    _timer = Timer.periodic(Duration(seconds: duration), (timer) {
      _ringtonePlayer.playAlarm();
      Future.delayed(Duration(seconds: 2), () {
        _ringtonePlayer.stop();
        if (ref.watch(riverpod_times) > 1) {
          setState(() {
            progress = 1.0;
            _isCold = !_isCold;
            ref.read(riverpod_times.notifier).state--;
            _startTimer();
          });
        } else if (ref.watch(riverpod_times) == 1) {
          _timer?.cancel();
          ref.read(riverpod_times.notifier).state--;
          Navigator.pushNamed(context, '/end');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isCold ? Color(0xff1241cd) : Color(0xFFc0000b),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    value: progress,
                    strokeWidth: 6,
                    valueColor: _isCold
                        ? AlwaysStoppedAnimation<Color>(Color(0xff1241cd))
                        : AlwaysStoppedAnimation<Color>(Color(0xFFc0000b)),
                  ),
                ),
                GestureDetector(
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) => Text(
                      countText,
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Center(
            child:  GradientOutlinedButton(
              onPressed: () {
                _end = true;
                setState(() {
                  _end = true;
                });
                _startTimer();
              },
            child: Icon(
              Icons.stop,
              color: Colors.white,
              size: 60,
            ),
            gradient: LinearGradient(
              colors: <Color>[
                Colors.white,
                Colors.white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          ),
          Container(width: 70,height: 70,)
        ],
      ),
    );
  }
}
