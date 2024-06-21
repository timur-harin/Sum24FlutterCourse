import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:education/templates/middleAssignment/data/functions.dart';
import 'package:education/templates/middleAssignment/data/provider/providers.dart';
import 'package:education/templates/middleAssignment/data/shower_session.dart';
import 'package:education/templates/middleAssignment/ui/theme/constants.dart';
import 'package:education/templates/middleAssignment/ui/widgets/level_dropdown_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ShowerPage extends ConsumerStatefulWidget {
  const ShowerPage({super.key});

  @override
  ConsumerState<ShowerPage> createState() => _ShowerPageState();
}

class _ShowerPageState extends ConsumerState<ShowerPage> {
  late int initCycles = 0;
  late int initNumberInCycle = 0;

  int actual_number = 0;

  int time_left = 0;

  DateTime start = DateTime.now();
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ref.read(stateProvider);
    ref.read(sessionProvider);
    ref.read(valueProvider);
    ref.read(cyclesNumberProvider);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(stateProvider);
    final session = ref.watch(sessionProvider);
    final valueScreen = ref.watch(valueProvider);
    final cyclesNumber = ref.watch(cyclesNumberProvider);

    void startCycle(int numberCycles, int numberInCycle) {
      time_left = numberInCycle;
      final cycles = numberCycles;
      const oneSec = const Duration(seconds: 1);
      _timer = new Timer.periodic(
        oneSec,
        (Timer timer) {
          if (time_left == 0) {
            if (cycles > 0) {
              setState(() {
                timer.cancel();
              });
              cyclesNumber.decrease();
              actual_number++;
              state.change();
              startCycle(cycles - 1, numberInCycle);
            } else {
              timer.cancel();
            }
          } else {
            setState(() {
              time_left--;
            });
          }
        },
      );
    }

    String level = "Easy";
    String selectedItem = "Easy";
    return Scaffold(
        backgroundColor: state.color,
        appBar: AppBar(
          title: const Text(
            "Active session",
            style: headingStyle,
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Column(
            children: [
              const Text(
                "Choose the level of contrast shower",
                style: subHeadingStyle,
              ),
              const Padding(padding: EdgeInsets.only(top: paddingSize)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButtonHideUnderline(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                      ),
                      child: DropdownButton2(
                          buttonStyleData: ButtonStyleData(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.lightBlue),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          items: levelList
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: bodyTextStyle,
                                    ),
                                  ))
                              .toList(),
                          value: valueScreen.level,
                          onChanged: (value) {
                           
                            if (value == "Easy") {
                              valueScreen.setEasy();
                              cyclesNumber.set(4);
                            } else if (value == "Medium") {
                              valueScreen.setMedium();
                              cyclesNumber.set(6);
                            } else if (value == "Hard") {
                              valueScreen.setHard();
                              cyclesNumber.set(8);
                            }
                          }),
                    ),
                    // LevelDropdownButton(function: (value) {
                    //   level = value;
                    //   if (level == "Easy") {
                    //     // valueScreen.setEasy();
                    //     // cyclesNumber.set(4);
                    //   } else if (level == "Medium") {
                    //     // valueScreen.setMedium();
                    //     // cyclesNumber.set(6);
                    //   } else if (level == "Hard") {
                    //     // valueScreen.setHard();
                    //     // cyclesNumber.set(8);
                    //   }
                    // }),
                  )
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: paddingSize)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'all cycles ',
                    style: bodyTextStyle,
                  ),
                  const Padding(padding: EdgeInsets.only(left: paddingSize)),
                  Text(
                    // "",
                    '${valueScreen.cycles}',
                    style: bodyTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'seconds in cycle ',
                    style: bodyTextStyle,
                  ),
                  const Padding(padding: EdgeInsets.only(left: paddingSize)),
                  Text(
                    // "",
                    '${valueScreen.timeInCycle}',
                    style: bodyTextStyle,
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    start = DateTime.now();
                    startCycle(initCycles, initNumberInCycle);
                    state.start();
                  },
                  child: const Text(
                    "start",
                    style: buttonTextStyle,
                  )),
              const Padding(padding: EdgeInsets.only(top: paddingSize)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.only(left: paddingSize)),
                  const Text(
                    'current temperature: ',
                    style: bodyTextStyle,
                  ),
                  const Padding(padding: EdgeInsets.only(left: paddingSize)),
                  Text(
                    '${state.state}',
                    style: bodyTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'seconds in cycle left:',
                    style: bodyTextStyle,
                  ),
                  const Padding(padding: EdgeInsets.only(left: paddingSize)),
                  Text(
                    '$time_left',
                    style: bodyTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'cycles left',
                    style: bodyTextStyle,
                  ),
                  const Padding(padding: EdgeInsets.only(left: paddingSize)),
                  Text(
                    // "",
                    '${valueScreen.number_cycles}',
                    style: bodyTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'total time',
                    style: bodyTextStyle,
                  ),
                  const Padding(padding: EdgeInsets.only(left: paddingSize)),
                  Text(
                    state.state == "Initial" ? '00:00' : formatDuration(DateTime.now().difference(start)),
                    style: bodyTextStyle,
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    session.addSession(ShowerSession(
                      name: 'Workout $actual_number',
                      level: level,
                      startTime: start,
                      endTime: start.add(
                          Duration(seconds: initCycles * initNumberInCycle)),
                      // duration: start.add(Duration(seconds: number)).difference(start),
                    ));
                    Navigator.of(context).pushNamed('/finish');
                  },
                  child: const Text("FINISH"))
            ],
          ),
        ));
  }
}
