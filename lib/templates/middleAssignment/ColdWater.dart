import 'package:education/templates/middleAssignment/HomePage.dart';
import 'package:education/templates/middleAssignment/HotWater.dart';
import 'package:education/templates/middleAssignment/SessionSummary.dart';
import 'package:education/templates/middleAssignment/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/round-button.dart';
import 'package:flutter/cupertino.dart';

class ColdWater extends ConsumerStatefulWidget {

  final int overallTime, repetitions;

  const ColdWater({super.key, required this.overallTime, required this.repetitions});

  @override
  _ColdWaterState createState() => _ColdWaterState(overallTime: overallTime, repetitions: repetitions);
}
class _ColdWaterState extends ConsumerState<ColdWater> with TickerProviderStateMixin {
  late AnimationController controller;
  int overallTime, repetitions;

  _ColdWaterState({required this.overallTime, required this.repetitions});

  bool isPlaying = true;
  String itog = '00 : 00 : 00';

  String get countText {
    Duration count = controller.duration! * controller.value;
    itog = controller.isDismissed ? '${(controller.duration!.inHours % 60).toString().padLeft(2, '0')} : ${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')} : ${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}' : '${(count.inHours % 60).toString().padLeft(2, '0')} : ${(count.inMinutes % 60).toString().padLeft(2, '0')} : ${(count.inSeconds % 60).toString().padLeft(2, '0')}';
    return itog;
  }

  double progress = 1.0;
  

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this, 
      duration: ref.read(riverpodColdTimer),
    );

    controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);

    void change() {
    if (countText == '00 : 00 : 00') {
      if (repetitions > 1) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HotWater(overallTime: overallTime + ref.read(riverpodColdTimer).inSeconds, repetitions: repetitions - 1))); 
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SessionSummary(overallTime: overallTime + ref.read(riverpodColdTimer).inSeconds, repetitions: repetitions - 1)));
      }
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
      backgroundColor: Color(0xfff5fbff),
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
                      backgroundColor: Colors.blue.shade300,
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => SessionSummary(overallTime: overallTime + ref.read(riverpodColdTimer).inSeconds - int.parse(itog.split(' ')[4]), repetitions: repetitions)));
            }, 
            child: Text('End')),
        ],
      ),
    );
  }
}