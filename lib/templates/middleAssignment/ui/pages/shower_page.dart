import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:education/templates/middleAssignment/data/functions.dart';
import 'package:education/templates/middleAssignment/data/provider/providers.dart';
import 'package:education/templates/middleAssignment/data/models/shower_session.dart';
import 'package:education/templates/middleAssignment/ui/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ShowerPage extends ConsumerStatefulWidget {
  const ShowerPage({super.key});

  @override
  ConsumerState<ShowerPage> createState() => _ShowerPageState();
}

class _ShowerPageState extends ConsumerState<ShowerPage> {
  int actualNumber = 0;

  int timeLeft = 0;

  DateTime start = DateTime.now();
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    ref.read(stateProvider);
    ref.read(sessionProvider);
    ref.read(valueProvider);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(stateProvider);
    final session = ref.watch(sessionProvider);
    final valueScreen = ref.watch(valueProvider);

    void startCycle(int numberCycles, int numberInCycle) {
      timeLeft = numberInCycle;
      final cycles = numberCycles;
      const oneSec = Duration(seconds: 1);
      _timer = Timer.periodic(
        oneSec,
        (Timer timer) {
          if (timeLeft == 0) {
            if (cycles > 0) {
              setState(() {
                timer.cancel();
              });
              valueScreen.decreaseCycles();
              actualNumber++;
              state.change();
              startCycle(cycles - 1, numberInCycle);
            } else {
              timer.cancel();
            }
          } else {
            setState(() {
              actualNumber++;
              timeLeft--;
            });
          }
        },
      );
    }

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
                                color: const Color.fromARGB(151, 94, 103, 132),
                                border: Border.all(
                                    color: state.isHot
                                        ? Colors.black
                                        : buttonBorderColor,
                                    width: 1),
                                borderRadius: BorderRadius.circular(25)),
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
                            } else if (value == "Medium") {
                              valueScreen.setMedium();
                            } else if (value == "Hard") {
                              valueScreen.setHard();
                            }
                          }),
                    ),
                  )
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 2 * paddingSize)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'all cycles: ',
                    style: bodyTextStyle,
                  ),
                  const Padding(padding: EdgeInsets.only(left: paddingSize)),
                  Text(
                    '${valueScreen.cycles}',
                    style: bodyTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'seconds in cycle: ',
                    style: bodyTextStyle,
                  ),
                  const Padding(padding: EdgeInsets.only(left: paddingSize)),
                  Text(
                    '${valueScreen.timeInCycle}',
                    style: bodyTextStyle,
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 2 * paddingSize)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    width: 100,
                    child: ElevatedButton(
                        style: state.style.copyWith(
                          backgroundColor: WidgetStateProperty.all(
                              Color(Colors.lightGreen.value)),
                        ),
                        onPressed: () {
                          start = DateTime.now();

                          startCycle(
                              valueScreen.cycles, valueScreen.timeInCycle);
                          state.start();
                        },
                        child: const Text("Start", style: buttonTextStyle)),
                  ),
                  const Padding(padding: EdgeInsets.only(left: paddingSize)),
                  SizedBox(
                    height: 40,
                    width: 100,
                    child: ElevatedButton(
                        style: state.style.copyWith(
                          backgroundColor: WidgetStateProperty.all(
                              const Color.fromARGB(255, 190, 58, 58)),
                        ),
                        onPressed: () {
                          start = DateTime.now();

                          state.reset();
                          valueScreen.reset();
                          setState(() {
                            timeLeft = 0;
                          });
                          _timer == null ? print("") : _timer!.cancel();
                        },
                        child: const Text(
                          "Reset",
                          style: buttonTextStyle,
                        )),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 2 * paddingSize)),
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
              const Padding(
                padding: EdgeInsets.only(top: smallPaddingSize),
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
                    '$timeLeft',
                    style: bodyTextStyle,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: smallPaddingSize),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'cycles left:',
                    style: bodyTextStyle,
                  ),
                  const Padding(padding: EdgeInsets.only(left: paddingSize)),
                  Text(
                    state.state == "Initial"
                        ? "0"
                        : '${valueScreen.cycles_left}',
                    style: bodyTextStyle,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: smallPaddingSize),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'total time:',
                    style: bodyTextStyle,
                  ),
                  const Padding(padding: EdgeInsets.only(left: paddingSize)),
                  Text(
                    state.state == "Initial"
                        ? '00:00'
                        : "${formatSeconds(actualNumber)}",
                    // formatDuration(DateTime.now().difference(start)
                    // ),
                    style: bodyTextStyle,
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 2 * paddingSize)),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                    style: state.style.copyWith(
                      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                          return const Color(0xFF2196F3);
                        },
                      ),
                    ),
                    onPressed: () {
                      session.addSession(ShowerSession(
                          level: valueScreen.level,
                          startTime:
                              DateFormat("dd-MM-yyyy HH:mm:ss").format(start),
                          totalTime: formatSeconds(actualNumber),
                          numbOfCycles:
                              valueScreen.cycles - valueScreen.cycles_left,
                          rate: "1"));

                      setState(() {
                        timeLeft = 0;
                      });
                      _timer == null ? print("") : _timer!.cancel();
                      // session.saveSessions();
                      // print(
                      //     "${formatDuration( Duration(seconds: valueScreen.cycles  * valueScreen.timeInCycle))}");
                      Navigator.of(context).pushNamed('/finish');
                    },
                    child: const Text(
                      "Finish",
                      style: buttonTextStyle,
                    )),
              ),
            ],
          ),
        ));
  }
}
