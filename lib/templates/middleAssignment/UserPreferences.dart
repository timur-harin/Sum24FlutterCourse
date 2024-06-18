import 'dart:ffi';

import 'package:education/templates/middleAssignment/HotWater.dart';
import 'package:education/templates/middleAssignment/SessionOverview.dart';
import 'package:education/templates/middleAssignment/riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPreferences extends ConsumerStatefulWidget {
  const UserPreferences({super.key});

  @override
  _UserPreferencesState createState() => _UserPreferencesState();
}

class _UserPreferencesState extends ConsumerState<UserPreferences> with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controller2;

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed ? '${(controller.duration!.inHours % 60).toString().padLeft(2, '0')} : ${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')} : ${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}' : '${(count.inHours % 60).toString().padLeft(2, '0')} : ${(count.inMinutes % 60).toString().padLeft(2, '0')} : ${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  String get countText2 {
    Duration count = controller2.duration! * controller2.value;
    return controller2.isDismissed ? '${(controller2.duration!.inHours % 60).toString().padLeft(2, '0')} : ${(controller2.duration!.inMinutes % 60).toString().padLeft(2, '0')} : ${(controller2.duration!.inSeconds % 60).toString().padLeft(2, '0')}' : '${(count.inHours % 60).toString().padLeft(2, '0')} : ${(count.inMinutes % 60).toString().padLeft(2, '0')} : ${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  double progress = 1.0;

  final numOfRepetitions = TextEditingController();


  Duration time1 = Duration(hours: 0, minutes: 0, seconds: 0);
  Duration time2 = Duration(hours: 0, minutes: 0, seconds: 0);
  Duration time3 = Duration(hours: 0, minutes: 0, seconds: 0);
  Duration fullTime = Duration(hours: 0, minutes: 0, seconds: 0);
  int overallTime = 0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this, 
      duration: Duration(seconds: 0),
    );

    controller2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 0),
    );



    controller.addListener(() {
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

    controller2.addListener(() {
      if (controller2.isAnimating) {
        setState(() {
          progress = controller2.value;
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
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Shower: User Preferences'),
      ),
      body: Container(  
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector (
                  onTap: () {
                    if (controller.isDismissed) {
                      showModalBottomSheet(
                      context: context, 
                      builder: (context) => Container(
                        height: 300,
                        child: CupertinoTimerPicker(
                          initialTimerDuration: time1,
                          onTimerDurationChanged: (time) {
                            setState(() {
                              controller.duration = time;
                              time1 = time;
                              time = Duration(hours: 0, minutes: 0, seconds: 0);
                            });
                          },
                        ),
                      ),
                    );
                  }
                },
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) => Text(
                    countText,
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Text('Hot shower time: ${(time1.inHours % 60).toString().padLeft(2, '0')} : ${(time1.inMinutes % 60).toString().padLeft(2, '0')} : ${(time1.inSeconds % 60).toString().padLeft(2, '0')}'),
              GestureDetector (
                  onTap: () {
                    if (controller.isDismissed) {
                      showModalBottomSheet(
                      context: context, 
                      builder: (context) => Container(
                        height: 300,
                        child: CupertinoTimerPicker(
                          initialTimerDuration: time2,
                          onTimerDurationChanged: (time) {
                            setState(() {
                              controller2.duration = time;
                              time2 = time;
                            });
                          },
                        ),
                      ),
                    );
                  }
                },
                child: AnimatedBuilder(
                  animation: controller2,
                  builder: (context, child) => Text(
                    countText2,
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Text('Cold shower time: ${(time2.inHours % 60).toString().padLeft(2, '0')} : ${(time2.inMinutes % 60).toString().padLeft(2, '0')} : ${(time2.inSeconds % 60).toString().padLeft(2, '0')}'),
              TextField(
                decoration: InputDecoration(hintText: 'Enter number of repetitions'), 
                controller: numOfRepetitions,),
                SizedBox(height: 100,),
                ElevatedButton(
                  onPressed: () {
                    for (var i = 0; i < int.parse(numOfRepetitions.text); i++) {
                      fullTime += (time1 + time2);
                    }
                    ref.read(riverpodFullTimer.notifier).state = fullTime;
                    ref.read(riverpodHotTimer.notifier).state = time1;
                    ref.read(riverpodColdTimer.notifier).state = time2;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SessionOverview(overallTime: overallTime, repetitions: int.parse(numOfRepetitions.text))));
                }, child: Text('Apply'),
                ),
          ],
        ),
      ),
    );
  }
}
