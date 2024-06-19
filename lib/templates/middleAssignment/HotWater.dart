import 'dart:io';

import 'package:education/templates/middleAssignment/ColdWater.dart';
import 'package:education/templates/middleAssignment/SessionSummary.dart';
import 'package:education/templates/middleAssignment/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/round-button.dart';
import 'package:flutter/cupertino.dart';

class HotWater extends ConsumerStatefulWidget {

  final int overallTime, repetitions;

  const HotWater({super.key, required this.overallTime, required this.repetitions});

  @override
  _HotWaterState createState() => _HotWaterState(overallTime: overallTime, repetitions: repetitions);
}
class _HotWaterState extends ConsumerState<HotWater> with TickerProviderStateMixin {
  int overallTime, repetitions;

  _HotWaterState({required this.overallTime, required this.repetitions});

  late AnimationController controller;
  String itog = '00 : 00 : 00';

  bool isPlaying = true;

  String get countText {
    Duration count = controller.duration! * controller.value;
    itog = controller.isDismissed ? '${(controller.duration!.inHours % 60).toString().padLeft(2, '0')} : ${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')} : ${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}' : '${(count.inHours % 60).toString().padLeft(2, '0')} : ${(count.inMinutes % 60).toString().padLeft(2, '0')} : ${(count.inSeconds % 60).toString().padLeft(2, '0')}';
    return itog;
  }

  double progress = 1.0;
  bool isHot = true;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this, 
      duration: ref.read(riverpodHotTimer),
    );

    controller.reverse(
      from: controller.value == 0 ? 1.0 : controller.value
    );

    void change() {
    if (countText == '00 : 00 : 00') {
      if (isHot) {
        controller = AnimationController(
          vsync: this, 
          duration: ref.read(riverpodColdTimer),
        );
        controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);
        isHot = false;
      } else {
        controller = AnimationController(
          vsync: this, 
          duration: ref.read(riverpodHotTimer),
        );
        controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);
        isHot = true;
      }
      //Navigator.push(context, MaterialPageRoute(builder: (context) => ColdWater(overallTime: overallTime + ref.read(riverpodHotTimer).inSeconds, repetitions: repetitions)));
    }
  }

    controller.addListener(() {
      change();
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isHot ? Color.fromARGB(255, 246, 46, 46) : Color.fromARGB(255, 33, 153, 232),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 400,
                    height: 400,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      value: progress,
                      strokeWidth: 6,
                    ),
                  ),
                  GestureDetector (
                  child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) => Text(
                    countText,
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),     
        ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector (
                  onTap: () {
                    if (controller.isAnimating) {
                      controller.stop();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      controller.reverse(
                      from: controller.value == 0 ? 1.0 : 
                      controller.value); 
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  child: RoundButton(
                    icon: isPlaying == true ? Icons.pause : Icons.play_arrow,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.reset();
                    setState(() {
                      isPlaying = false;
                    });
                  },
                  child: RoundButton(
                    icon: Icons.stop,
                  ),
                ),
                
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              
              setState(() {
                isPlaying = false;
              });
              Navigator.push(context, MaterialPageRoute(builder: (context) => SessionSummary(overallTime: overallTime + ref.read(riverpodHotTimer).inSeconds - int.parse(itog.split(' ')[4]), repetitions: repetitions)));
            }, 
            child: Text('End')),
        ],
      ),
    );
  }
}