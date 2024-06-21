import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:education/templates/middleAssignment/providers/cycles_provider.dart';
import 'package:education/templates/middleAssignment/providers/duration_provider.dart';
import 'package:education/templates/middleAssignment/providers/shower_take_provider.dart';
import 'package:education/templates/middleAssignment/providers/tempreture_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/middleAssignment/data/shower_take.dart';
import 'package:percent_indicator/percent_indicator.dart';


class TakeShowerPage extends ConsumerStatefulWidget {
  const TakeShowerPage({super.key});

  @override
  ConsumerState<TakeShowerPage> createState() => _TakeShowerPageState();
}

class _TakeShowerPageState extends ConsumerState<TakeShowerPage> {
  DateTime start = DateTime.now();
  late Timer _timer;
  
  int number_cycles = 0;
  int actual_number = 0;
  int time_left = 0;
  int cycles_left = 0;
  bool paused = false;
  int begin_cycles = 0;
  int cycleDuration = 0;
  Color backgroundColor = Colors.white;
  Color coldColor = const Color(0xFF123C69);
  Color hotColor = const Color(0xFFAC3B61);
  final alarmAudioPath = "sound_alarm1.mp3";
  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playAlarm() async {
    await audioPlayer.play(AssetSource(alarmAudioPath));
  }

  void startTimer(int numberCycles, int numberInCycle) {
    cycles_left = numberCycles;
    time_left = numberInCycle;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        print("$cycleDuration $begin_cycles $actual_number");
        if (time_left == 0) {
          if (numberCycles > 1) {
            setState(() {
              timer.cancel();
            });
            number_cycles--;
            startTimer(numberCycles - 1, numberInCycle);
            ref.read(tempretureProvider.notifier).switchState();
            
            if (ref.watch(tempretureProvider) == "Cold Now") {
              backgroundColor = coldColor;
            } else {
              backgroundColor = hotColor;
            }
          } else {
            timer.cancel();
            finish();
          }
        } else if (paused) {
          
        } else {
          setState(() {
            actual_number++;
            time_left--;
          });
        }
      },
    );
  }

  void finish() {
    ref.read(showerTakesProvider.notifier).addShowerTake(
      ShowerTake(
        'Shower ${ref.watch(showerTakesProvider).length + 1}',
        actual_number,
        actual_number ~/ ref.watch(durationProvider),
        start,
        endTime: DateTime.now(),
      )
    );
    ref.read(cyclesProvider.notifier).setState(actual_number ~/ ref.watch(durationProvider));
    ref.read(durationProvider.notifier).setState(actual_number);
    ref.read(tempretureProvider.notifier).setState("Cold Now");

    Navigator.of(context).pushNamed('/finish');
  }

  @override
  Widget build(BuildContext context) {
    backgroundColor = ref.watch(tempretureProvider) == "Cold Now" ? coldColor : hotColor;
    begin_cycles = ref.watch(cyclesProvider);
    cycleDuration = ref.watch(durationProvider);
    bool buttonClicked = false;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Take a Shower!', style: TextStyle(color: Color(0xFFEEE2DC)),),
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Aim Cycles: $begin_cycles', style: const TextStyle(color: Color(0xFFEEE2DC)),),
                Text('Aim Cycle Duration: ${ref.watch(durationProvider)}', style: const TextStyle(color: Color(0xFFEEE2DC)),),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: LinearPercentIndicator(
                    alignment: MainAxisAlignment.center,
                    width: MediaQuery.of(context).size.width * 0.5,
                    // animation: true,
                    lineHeight: 20.0,
                    // animationDuration: 2500,
                    percent: actual_number / ((cycleDuration) * (begin_cycles)),
                    center: Text('${
                      actual_number * 100 ~/ ((cycleDuration) * (begin_cycles))
                      }%', style: const TextStyle(color:  Color(0xFF123C69)),),
                    barRadius: const Radius.circular(10),
                    progressColor: const Color(0xFFEEE2DC),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                ElevatedButton(
                  onPressed: buttonClicked ? null : () {
                    start = DateTime.now();
                    startTimer(ref.watch(cyclesProvider), ref.watch(durationProvider));
                    setState(() {
                      buttonClicked = true;
                    });
                  },
                  child: const Text('Start'),
                  style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all<Color>(const Color(0xFF123C69)),
                      backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFFEEE2DC)),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Text('Time: $time_left ', style: const TextStyle(color: Color(0xFFEEE2DC)),),
                Text('Cycles: $cycles_left', style: const TextStyle(color: Color(0xFFEEE2DC)),),

                const SizedBox(
                  height: 10,
                ),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      paused = !paused;
                    });
                  },
                  child: Text(
                    paused ? 'Resume' : 'Pause',
                  ),
                  style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all<Color>(const Color(0xFFAC3B61)),
                      backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFFEEE2DC)),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                ElevatedButton(
                  onPressed: finish,
                  child: const Text('Finish'),
                  style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all<Color>(const Color(0xFFAC3B61)),
                      backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFFEEE2DC)),
                  ),
                ),
              ]
            )
          ],
        ),
      )
    );
  }
}